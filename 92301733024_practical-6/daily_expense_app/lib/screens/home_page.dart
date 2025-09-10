import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:daily_expense_app/controller/expense_controller.dart';
import 'package:daily_expense_app/screens/add_expense.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static ExpenseController controller = Get.put(ExpenseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFb6d8ae),
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hello,", style: TextStyle(fontSize: 24)),
                          Text("Isha Savaliya",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications_none)),
                    ),
                  ],
                ),
                Obx(
                  () => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        outlinedButton(
                            "All", () => controller.selected.value = "All"),
                        outlinedButton(
                            "Daily", () => controller.selected.value = "Daily"),
                        outlinedButton("Weekly",
                            () => controller.selected.value = "Weekly"),
                        outlinedButton("Monthly",
                            () => controller.selected.value = "Monthly"),
                        outlinedButton("Yearly",
                            () => controller.selected.value = "Yearly"),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[100]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [incomeSpentSection(), pieChartSection()],
                  ),
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text("Recent transactions",
                          style: TextStyle(color: Colors.grey, fontSize: 20)),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        side: BorderSide(color: Colors.grey[300]!, width: 1.5),
                      ),
                      child: const Row(
                        children: [
                          Text("See All", style: TextStyle(color: Colors.grey)),
                          Icon(Icons.chevron_right, color: Colors.grey)
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      itemCount: controller.expenses.length,
                      itemBuilder: (context, index) {
                        final expense = controller.expenses[index];
                        return expenseCard(expense.amount, expense.category,
                            expense.paymentType, expense.timestamp);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddExpense()),
        backgroundColor: const Color(0xFFb7d9ae),
        child: Icon(Icons.add, color: Colors.grey[800]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => AnimatedBottomNavigationBar.builder(
          backgroundColor: Colors.white,
          itemCount: controller.iconList.length,
          activeIndex: controller.curBottomNavIndex.value,
          onTap: (index) => controller.curBottomNavIndex.value = index,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          tabBuilder: (int index, bool isActive) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(controller.iconList[index][0],
                    size: 24,
                    color:
                        isActive ? const Color(0xFFb7d9ae) : Colors.grey[800]),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(controller.iconList[index][1],
                      style: TextStyle(color: Colors.grey[800])),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget outlinedButton(String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          side: BorderSide(
            color: controller.selected.value == label
                ? const Color(0xFFb6d8ae)
                : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Text(label,
            style: TextStyle(
                color: controller.selected.value != label
                    ? Colors.grey
                    : Colors.black)),
      ),
    );
  }

  Widget incomeSpentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelAndValue("Income", controller.income, const Color(0xFFb6d8ae)),
        const SizedBox(height: 20),
        labelAndValue("Spent", controller.spent, const Color(0xFFfeb9ab)),
      ],
    );
  }

  Widget labelAndValue(String label, RxDouble value, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                width: 5,
                height: 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3), color: color)),
            Text(" $label"),
          ],
        ),
        Obx(
          () => Text(
              "₹${value.value % 1 == 0.0 ? value.value.toInt() : value.value.toStringAsFixed(2)}",
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget pieChartSection() {
    return Obx(
      () => SizedBox(
        width: 165,
        height: 165,
        child: PieChart(
          PieChartData(
            sectionsSpace: 0,
            centerSpaceRadius: 40,
            sections: [
              PieChartSectionData(
                color: const Color(0xFFb6d8ae),
                value: controller.income.value,
                title: "Income",
                radius: 30,
              ),
              PieChartSectionData(
                color: const Color(0xFFfeb9ab),
                value: controller.spent.value,
                title: "Spent",
                radius: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget expenseCard(
      double amount, String category, String paymentType, String timestamp) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: category == "Food"
                  ? const Color(0xFFfaedd4)
                  : category == "Salary"
                      ? const Color(0xFFe9f3e6)
                      : const Color(0xFFd4e3fa), // ✅ Added fallback color
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(paymentType, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Text("₹$amount", style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
