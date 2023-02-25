import 'package:flutter/material.dart';
import 'package:psmna10/settings/styles_settings.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData;
  ThemeProvider(BuildContext context) {
    _themeData = StylesSettings.lightTheme(context);
  }

  getthemeData() => _themeData;
  setthemeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}
