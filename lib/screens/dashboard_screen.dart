import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psmnn/provider/theme_provider.dart';
import 'package:psmnn/screens/list_post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkModeEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadDarkModeEnabled();
  }

  Future<void> _loadDarkModeEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkModeEnabled = prefs.getBool('is_dark') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social TEC'),
      ),
      body: ListPost(),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/itce.png'),
                  //NetworkImage(
                  //'https://static.wikia.nocookie.net/liga-mx/images/1/11/LTClogoant.png/revision/latest?cb=20200826190754&path-prefix=es'),
                ),
                accountName: Text('Guadalupe Sanchez'),
                accountEmail: Text('19030053@itcelaya.edu.mx')),
            ListTile(
              onTap: () {},
              title: const Text('Práctica 1'),
              subtitle: const Text('Descripción de la práctica'),
              leading: const Icon(Icons.settings),
              trailing: const Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/theme');
              },
              title: const Text('Cambiar tema'),
              subtitle: const Text('Selecciona el tema de la aplicación.'),
              leading: const Icon(Icons.settings),
              trailing: const Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              title: const Text('Cerrar sesión'),
              leading: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }
}
