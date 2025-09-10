import '../models/expense.dart';

class ExpenseController {
  final List<Expense> _expenses = [];

  List<Expense> get expenses => List.unmodifiable(_expenses);

  double get balance => _expenses.fold(0.0, (sum, e) => sum + e.amount);

  void addExpense(String title, String type, double amount) {
    final expense = Expense(
      title: title,
      type: type,
      amount: amount,
      createdAt: DateTime.now(),
    );
    _expenses.insert(0, expense); // newest first
  }

  void removeAt(int index) {
    _expenses.removeAt(index);
  }

  void clearAll() {
    _expenses.clear();
  }
}
