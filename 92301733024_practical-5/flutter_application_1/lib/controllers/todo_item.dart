// This file defines the ToDoItem widget to display each todo in a list

import 'package:flutter/material.dart';
import '../model/todo.dart'; // Importing the ToDo model

class ToDoItem extends StatelessWidget {
  final ToDo todo; // The ToDo item to be displayed
  final Function onToDoChanged; // Callback when a todo is toggled
  final Function onDeleteItem; // Callback when a todo is deleted

  const ToDoItem({
    super.key,
    required this.todo, // Required ToDo object
    required this.onToDoChanged, // Required callback for change
    required this.onDeleteItem, // Required callback for delete
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20), // Space between items
      child: ListTile(
        onTap: () {
          // Trigger when tapping on the todo item
          onToDoChanged(todo); // Call parent callback to toggle status
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white, // Background color
        leading: Icon(
          // Show checkbox or empty box based on isDone
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.blue,
        ),
        title: Text(
          todo.todoText ?? "",
          style: TextStyle(
            fontSize: 16,
            decoration: todo.isDone
                ? TextDecoration.lineThrough
                : null, // Strike through if done
          ),
        ),
        trailing: Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          child: IconButton(
            color: Colors.red, // Delete button color
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Trigger delete callback
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
