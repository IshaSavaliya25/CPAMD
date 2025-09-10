// This file defines the ToDo model class

class ToDo {
  // Unique identifier for the ToDo item
  String? id;

  // The text description of the ToDo item
  String? todoText;

  // Flag to indicate whether the ToDo item is completed or not
  bool isDone;

  // Constructor for the ToDo class
  // 'id' and 'todoText' are required, 'isDone' defaults to false
  ToDo({required this.id, required this.todoText, this.isDone = false});

  // Static method to return an empty list of ToDo items (can be prefilled later)
  static List<ToDo> todoList() {
    return [];
  }
}
