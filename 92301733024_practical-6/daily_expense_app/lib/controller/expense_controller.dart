import 'package:daily_expense_app/model/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExpenseController extends GetxController {
  var selected = "All".obs;
  var curBottomNavIndex = 0.obs;

  var income = 0.0.obs;
  var spent = 0.0.obs;

  RxList<ExpenseData> expenses = <ExpenseData>[].obs;

  var category = "Food".obs;
  var paymentType = "Cash".obs;

  TextEditingController amountCntrl = TextEditingController();

  double amount = 0.0;

  List<List<dynamic>> iconList = [
    [Icons.home, "Home"],
    [Icons.swap_horiz, "Transfer"],
    [Icons.account_balance_wallet_outlined, "Wallet"],
    [Icons.account_circle_outlined, "Profile"],
  ];

  void saveData() {
    final newExpense = ExpenseData(
      amount: double.tryParse(amountCntrl.text) ?? 0,
      category: category.value,
      paymentType: paymentType.value,
      timestamp: DateFormat('MMM dd, yyyy').format(DateTime.now()),
    );

    expenses.add(newExpense);
    if (category.value == "Salary") {
      income.value += newExpense.amount;
    } else {
      spent.value += newExpense.amount;
    }
  }
}
