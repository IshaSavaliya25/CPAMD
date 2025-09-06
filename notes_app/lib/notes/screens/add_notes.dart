import 'package:flutter/material.dart';

class AddNotes extends StatelessWidget {
  const AddNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Title',
                labelText: 'Title',
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.add, size: 40)),
        ],
      ),
    );
  }
}
