import 'package:flutter/material.dart';
import 'package:psmnn/screens/Register_screen.dart';
import 'package:psmnn/screens/dashboard_screen.dart';
import 'package:psmnn/screens/login_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/login': (BuildContext context) => const LoginScreen(),
    '/register': (BuildContext context) => const RegisterScreen(),
    '/dash': (BuildContext context) => const DashboardScreen(),
  };
}
