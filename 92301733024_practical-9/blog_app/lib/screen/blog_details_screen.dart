import 'package:flutter/material.dart';

import '../models/blog.dart';
import '../services/firebase_services.dart';

class BlogDetailsScreen extends StatefulWidget {
  final Blog? blog;
  const BlogDetailsScreen({super.key, this.blog});
  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _content;

  @override
  void initState() {
    super.initState();
    if (widget.blog != null) {
      _title = widget.blog!.title!;
      _content = widget.blog!.description!;
    } else {
      _title = '';
      _content = '';
    }
  }

  void _saveBlog() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // final blog = Blog(
      //   id: widget.blog?.id,
      //   title: _title,
      //   description: _content,
      // );
//todo code to store on firestore
      FirebaseServices().addBlog(_title, _content);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.blog == null ? 'New Blog' : 'Edit Blog'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _content,
                decoration: const InputDecoration(labelText: 'Content'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
                onSaved: (value) {
                  _content = value!;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveBlog,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
