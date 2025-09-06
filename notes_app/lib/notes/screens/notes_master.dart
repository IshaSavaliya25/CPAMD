import 'package:flutter/material.dart';
import 'package:notes_app/notes/screens/add_notes.dart';
import 'package:notes_app/notes/screens/display_notes.dart';

class NotesMaster extends StatelessWidget {
  const NotesMaster({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes App')),
      body: Column(
        children: [
          //add part
          AddNotes(),
          // display all notes
          Expanded(child: DisplayNotes()),
        ],
      ),
    );
  }
}
