import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:psmnn/provider/theme_provider.dart';
import 'package:psmnn/routes.dart';
import 'package:psmnn/screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(context)),
      ],
      child: const PMSNApp(),
    );
  }
}

class PMSNApp extends StatelessWidget {
  const PMSNApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    return GetMaterialApp(
      theme: theme.getthemeData(),
      routes: getApplicationRoutes(),
      home: const LoginScreen(),
    );
  }
}
