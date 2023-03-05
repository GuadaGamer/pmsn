import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:psmnn/provider/theme_provider.dart';
import 'package:psmnn/routes.dart';
import 'package:psmnn/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
  final idTema=sharedPreferences.getInt('id_tema')??0;
  runApp(MyApp( id_tema  :idTema));
}

class MyApp extends StatelessWidget {
  final int id_tema;
  const MyApp({super.key, required this.id_tema});
  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(id_tema, context)),
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
      home: Home(),
    );
  }
}
