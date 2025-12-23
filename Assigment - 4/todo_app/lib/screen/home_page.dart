import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constants/themes.dart';
import 'package:todo_app/controllers/home_page_controller.dart';
import 'package:todo_app/model/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.background,
      appBar: AppBar(
        title: Text('Todo List'.tr, style: TextStyle(color: MyTheme.text)),
        centerTitle: true,
        backgroundColor: MyTheme.background,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await controller.box.write(
                'darkMode',
                !(controller.box.read('darkMode') ?? true),
              );
              setState(() {});
            },
            icon: Icon(
              controller.box.read("darkMode") ?? true
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: MyTheme.text,
            ),
          ),
          IconButton(
            onPressed: () {
              _showLanguageDialog(context);
            },
            icon: Icon(Icons.language, color: MyTheme.text),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.titleController,
                    style: TextStyle(color: MyTheme.text),
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                      hintText: 'Enter Task Name'.tr,
                      hintStyle: TextStyle(color: MyTheme.text),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: MyTheme.text),
                      ),
                    ),
                    onSubmitted: (value) {
                      String task = controller.titleController.text;

                      if (task.isNotEmpty) {
                        controller.todos.add(
                          TodoModel(task, controller.todos.length, false),
                        );
                        controller.titleController.text = "";
                      }

                      setState(() {});
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    String task = controller.titleController.text;

                    if (task.isNotEmpty) {
                      controller.todos.add(
                        TodoModel(task, controller.todos.length, false),
                      );
                      controller.titleController.text = "";
                    }

                    setState(() {});
                  },
                  icon: Icon(Icons.add, color: MyTheme.text),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: 3,
              itemBuilder: (context, index) {
                return displayTodo();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: TabBar(
        labelPadding: const EdgeInsets.fromLTRB(0, 12, 0, 10),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: MyTheme.text,
        indicatorPadding: const EdgeInsets.fromLTRB(0, 0, 0, 42),
        controller: controller.tabController,
        tabs: [
          Text("All".tr, style: TextStyle(fontSize: 16, color: MyTheme.text)),
          Text(
            "Pending".tr,
            style: TextStyle(fontSize: 16, color: MyTheme.text),
          ),
          Text(
            "Completed".tr,
            style: TextStyle(fontSize: 16, color: MyTheme.text),
          ),
        ],
      ),
    );
  }

  Future<void> _showLanguageDialog(BuildContext context) async {
    // String? selectedLanguage = prefs.getString("selectedLanguage");
    // String? newLanguage = selectedLanguage;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: MyTheme.background,
          title: Text(
            'Select Language'.tr,
            style: TextStyle(color: MyTheme.text),
          ),
          content: DropdownButton<String>(
            isExpanded: true,
            value: controller.selectedLanguage,
            dropdownColor: MyTheme.background,
            iconEnabledColor: MyTheme.text,
            items: controller.languageCodes.keys.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: MyTheme.text)),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() async {
                controller.selectedLanguage = value!;
                Get.updateLocale(Locale(controller.languageCodes[value]!));
                await controller.box.write("selectedLanguage", value);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              });
            },
            style: TextStyle(color: MyTheme.text),
          ),
        );
      },
    );
  }

  Widget displayTodo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: ListView.builder(
        itemCount: controller.todos.length,
        itemBuilder: (context, index) =>
            (controller.tabController.index == 1 &&
                    controller.todos[index].completed) ||
                (controller.tabController.index == 2 &&
                    !controller.todos[index].completed)
            ? const SizedBox()
            : CheckboxListTile(
                contentPadding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                controlAffinity: ListTileControlAffinity.leading,
                secondary: IconButton(
                  onPressed: () {
                    controller.todos.removeAt(index);
                    controller.tabController.index =
                        controller.tabController.index;
                    setState(() {});
                  },
                  icon: Icon(Icons.delete, color: MyTheme.text),
                ),
                onChanged: (v) {
                  // Logic to toggle isCompleted
                  // todosToDisplay[index].completed = v!;
                  controller.todos[index].completed = v!;
                  setState(() {});
                },
                activeColor: MyTheme.text,
                checkColor: MyTheme.background,
                side: BorderSide(color: MyTheme.text),
                value: controller.todos[index].completed,
                title: Text(
                  controller.todos[index].task,
                  style: controller.todos[index].completed
                      ? TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: MyTheme.text,
                        )
                      : TextStyle(
                          color: MyTheme.text,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w700,
                        ),
                ),
              ),
      ),
    );
  }
}
