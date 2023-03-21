import 'package:flutter/material.dart';
import 'package:psmnn/screens/Register_screen.dart';
import 'package:psmnn/screens/add_post_dcreen.dart';
import 'package:psmnn/screens/calendario_screen.dart';
import 'package:psmnn/screens/dashboard_screen.dart';
import 'package:psmnn/screens/login_screen.dart';
import 'package:psmnn/screens/themeSelector_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/login': (BuildContext context) => const LoginScreen(),
    '/register': (BuildContext context) => const RegisterScreen(),
    '/dash': (BuildContext context) => const DashboardScreen(),
    '/theme': (BuildContext context) => const ThemeSelectorScreen(),
    '/add': (BuildContext context) => AddPostScreen(),
    '/calendario': (BuildContext context) => const CalendarioScreen(),
  };
}
