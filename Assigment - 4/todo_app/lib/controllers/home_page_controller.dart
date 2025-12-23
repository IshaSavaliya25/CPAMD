import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/model/todo_model.dart';

class HomePageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController titleController = TextEditingController();
  RxList<TodoModel> todos = <TodoModel>[].obs;

  late TabController tabController;
  late PageController pageController;

  final box = GetStorage();
  late String selectedLanguage;

  HomePageController() {
    tabController = TabController(length: 3, vsync: this);
    pageController = PageController(initialPage: 0);
    selectedLanguage = box.read('selectedLanguage') ?? 'English';
    tabController.addListener(() {
      pageController.animateToPage(
        tabController.index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  Map<String, String> languageCodes = {
    'English': 'en',
    'Hindi': 'hi',
    'Gujarati': 'gu',
    'Urdu': 'ur',
    'Marathi': 'mr',
  };
}
