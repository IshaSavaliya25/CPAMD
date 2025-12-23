import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/blog.dart';

class FirebaseServices {
  var db = FirebaseFirestore.instance;
  addBlog(String title, String description) {
    // Create a new note with a title and description
    final note = <String, dynamic>{"title": title, "description": description};

// Add a new document with a generated ID
    db.collection("blog").add(note).then((DocumentReference doc) =>
        // ignore: avoid_print
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  Stream<QuerySnapshot> fetchBlog() {
    Stream<QuerySnapshot> collectionStream =
        FirebaseFirestore.instance.collection('blog').snapshots();
    return collectionStream;
// Stream documentStream = FirebaseFirestore.instance.collection('users').doc('ABC123').snapshots();
  }

  updateBlog(Blog blog) {
    return db
        .collection("notes")
        .doc(blog.id)
        .update({'title': blog.title, 'description': blog.description})
        // ignore: avoid_print
        .then((value) => print("Note Updated"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to update Note: $error"));
  }

  deleteBlog(id) {
    return db
        .collection("blog")
        .doc(id)
        .delete()
        // ignore: avoid_print
        .then((value) => print("User Deleted"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
