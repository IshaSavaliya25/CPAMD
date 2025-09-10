import 'package:flutter/material.dart';
import '../controllers/expense_controller.dart';
import '../models/expense.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ExpenseController _controller = ExpenseController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _typeController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _addExpense(BuildContext sheetContext) {
    final title = _titleController.text.trim();
    final type = _typeController.text.trim();
    final amountText = _amountController.text.trim();

    if (title.isEmpty || type.isEmpty || amountText.isEmpty) {
      // optional: show snackbar or validation
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null) {
      // invalid number
      return;
    }

    setState(() {
      _controller.addExpense(title, type, amount);
    });

    // clear fields
    _titleController.clear();
    _typeController.clear();
    _amountController.clear();

    // close the bottom sheet using the sheet's context
    Navigator.of(sheetContext).pop();
  }

  void _showAddExpenseSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // so keyboard doesn't cover inputs
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Type'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _addExpense(ctx),
                      child: const Text('Add Expense'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final expenses = _controller.expenses;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
            tooltip: 'Clear all',
            onPressed: () {
              setState(() => _controller.clearAll());
            },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            color: Colors.blue.shade100,
            child: Text(
              "Balance: ₹${_controller.balance.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: expenses.isEmpty
                ? const Center(child: Text("No expenses yet!"))
                : ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (ctx, index) {
                      final Expense expense = expenses[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: ListTile(
                          title: Text(expense.title),
                          subtitle: Text(
                            "Type: ${expense.type}\n${expense.createdAt.toLocal()}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            "₹${expense.amount.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddExpenseSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}
