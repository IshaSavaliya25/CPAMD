import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager_firebase/model/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class ExpenseController extends GetxController {
  var selected = "All".obs;
  var curBottomNavIndex = 0.obs;

  var income = 0.0.obs;
  var spent = 0.0.obs;

  late RxList<ExpenseData> expenses;

  var category = "Food".obs;
  var paymentType = "Cash".obs;

  TextEditingController amountCntrl = TextEditingController();

  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> collection = fetchTransactions();

  final box = GetStorage();
  double amount = 0.0;

  List<List<dynamic>> iconList = [
    [Icons.home, "Home"],
    [Icons.swap_horiz, "Transfer"],
    [Icons.account_balance_wallet_outlined, "Wallet"],
    [Icons.account_circle_outlined, "Profile"],
  ];
  
  @override
  void onInit() {
    super.onInit();
    fetchSummaryData();
  }

  Future<void> fetchSummaryData() async {
    final data = (await firestore.doc("summury/summury").get()).data();

    if (data != null) {
      income.value = (data['income'] as double?) ?? 0.0;
      spent.value = (data['spent'] as double?) ?? 0.0;
    }
  }

  static Stream<QuerySnapshot> fetchTransactions() {
    CollectionReference transaction = firestore.collection("transactions");
    return transaction.orderBy('timestamp', descending: true).snapshots();
  }

  static deleteTranscation(String id) {
    String resp = '';
    DocumentReference docRef = firestore.collection("transactions").doc(id);

    docRef.delete().whenComplete(() {
      resp = 'Transaction deleted successfully';
    });
    return resp;
  }

  void saveData() {
    final newExpense = ExpenseData(
      amount: double.tryParse(amountCntrl.text) ?? 0,
      category: category.value,
      paymentType: paymentType.value,
      date: DateFormat('MMM dd, yyyy').format(DateTime.now()),
      timestamp: Timestamp.now().toString()
    );

    amountCntrl.text = '';
    firestore.collection("transactions").add(newExpense.toMap());

    if (category.value == "Salary") {
      income.value += newExpense.amount;
      firestore
          .doc("summury/summury")
          .set({"income": income.value}, SetOptions(merge: true));
    } else {
      spent.value += newExpense.amount;
      firestore
          .doc("summury/summury")
          .set({"spent": spent.value}, SetOptions(merge: true));
    }
  }
}
