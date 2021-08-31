import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeViewModel with ChangeNotifier {

  int _index = 0;
  int get index => _index;

  void setTheme(int index) async {
    if (index == _index) return;
    _index = index;
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt("themeIndex", _index);
    notifyListeners();
  }

  Future<int> getTheme() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt("themeIndex") ?? 0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("ThemeProvider.dispose");
  }
}