import 'package:flutter/material.dart';

class AppController with ChangeNotifier {
  int r = 100;
  int g = 100; 
  int b = 100;
  double opacity = 1.0;

  void updateColorR(double red){
    r = (red * 255).toInt();
    notifyListeners();
  }
  void updateColorG(double green){
    g = (green * 255).toInt();
    notifyListeners();
  }
  void updateColorB(double blue){
    b = (blue * 255).toInt();
    notifyListeners();
  }
}
