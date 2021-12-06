import 'package:flutter/material.dart';
import 'package:workshop_template/theme/theme.dart';

class SettingsController with ChangeNotifier {
  late ThemeData _themeData;

  ThemeData get themeData => _themeData;

  SettingsController() {
    _themeData = mercuryTheme;
  }

  void updateTheme(ThemeData newThemeData) {
    if (newThemeData == _themeData) return;

    _themeData = newThemeData;

    notifyListeners();
  }
}
