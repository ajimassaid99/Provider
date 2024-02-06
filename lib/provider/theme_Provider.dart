import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;
  String mode = 'light';
  Color selectedColor = Colors.blue;
 

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    
    if(_isDarkMode){
      mode = 'light';
      selectedColor = Colors.blue;

  }else{
    mode = 'drak';
    selectedColor = Colors.black;

  }
  notifyListeners();
  }

  ThemeData get themeData => _isDarkMode ? ThemeData.dark() : ThemeData.light();
}
