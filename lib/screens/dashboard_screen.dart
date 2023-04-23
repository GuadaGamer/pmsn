import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:psmnn/firebase/firebase_facebookauth.dart';
import 'package:psmnn/provider/theme_provider.dart';
import 'package:psmnn/screens/list_post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/add').then((value) {
            setState(() {});
          });
        },
        label: const Text('Add post'),
        icon: const Icon(Icons.add_comment),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL ?? 'assets/itce.png'),
                  //NetworkImage(
                  //'https://static.wikia.nocookie.net/liga-mx/images/1/11/LTClogoant.png/revision/latest?cb=20200826190754&path-prefix=es'),
                ),
                accountName: Text(FirebaseAuth.instance.currentUser!.displayName ?? 'Nombre de usuario'),
                accountEmail: Text(FirebaseAuth.instance.currentUser!.email ?? 'correo@ejemplo.com')),
            ListTile(
              onTap: (){
                Navigator.pushNamed(context, '/profile');
              },
              title: const Text('Perfil'),
              subtitle: const Text('Revisa tu perfil aqui'),
              leading: const Icon(Icons.view_comfy),
              trailing: const Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/eventos');
              },
              title: const Text('Eventos'),
              subtitle: const Text('Revisa los proximos eventos'),
              leading: const Icon(Icons.edit_calendar_sharp),
              trailing: const Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/popular');
              },
              title: const Text('API videos'),
              leading: const Icon(Icons.movie),
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
              onTap: () async {
                final googleSignIn = GoogleSignIn();
                await FirebaseAuth.instance.signOut();
                if (googleSignIn.isSignedIn() == true){  await googleSignIn.disconnect(); }
                await FacebookAuth.instance.logOut();
                Navigator.popAndPushNamed(context, '/login');
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
