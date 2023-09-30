import 'package:flutter/material.dart';

class NightModeProvider extends ChangeNotifier {
  var _themmode = ThemeMode.light;
  ThemeMode get thememode => _themmode;

  void setTheme(themMode) {
    _themmode = themMode;
    notifyListeners();
  }
}

class LoadingProvider extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;

  void setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }
}