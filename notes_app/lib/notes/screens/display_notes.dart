import 'package:flutter/material.dart';
import 'package:notes_app/notes/screens/widgets/note_widgets.dart';

class DisplayNotes extends StatelessWidget {
  const DisplayNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => NoteWidget(),
    );
  }
}
