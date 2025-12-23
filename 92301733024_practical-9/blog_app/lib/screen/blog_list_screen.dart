import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:blog_app/services/firebase_services.dart';

import '../models/blog.dart';
import 'blog_details_screen.dart';

class BlogListScreen extends StatelessWidget {
  const BlogListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseServices().fetchBlog(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.docs.isEmpty) {
            return const Text("No Blog found");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic>? data =
                  document.data() as Map<String, dynamic>?;

              if (data == null) {
                return const ListTile(
                  title: Text('No Data'),
                );
              }

              // Safely handle null for title and description
              String title = data['title'] ?? 'Untitled';
              String description = data['description'] ?? 'No description';

              Blog blog = Blog(
                id: document.id,
                title: title,
                description: description,
              );

              return ListTile(
                title: Text(blog.title!),
                subtitle: Text(blog.description!),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        // Navigate to edit blog screen
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlogDetailsScreen(blog: blog),
                        ));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Confirm deletion before deleting
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Delete Blog"),
                              content: const Text(
                                  "Are you sure you want to delete this blog?"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    FirebaseServices().deleteBlog(document.id);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Delete"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const BlogDetailsScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
