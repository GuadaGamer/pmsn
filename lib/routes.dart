import 'package:flutter/material.dart';
import 'package:psmnn/screens/Register_screen.dart';
import 'package:psmnn/screens/dashboard_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/register': (BuildContext context) => const RegisterScreen(),
    '/dash': (BuildContext context) => const DashboardScreen(),
  };
}
