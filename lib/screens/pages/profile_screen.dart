import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Center(
            child: Text('Mi perfil'),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.deepOrange.shade300],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.5, 0.9],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.red.shade300,
                        minRadius: 35.0,
                        child: const Icon(
                          Icons.call,
                          size: 30.0,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white70,
                        minRadius: 60.0,
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              NetworkImage(_user!.photoURL!),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.red.shade300,
                        minRadius: 35.0,
                        child: const Icon(
                          Icons.message,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    _user!.displayName!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Usuario de PMSN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: const Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      _user!.email!,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      'Numero',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      _user!.phoneNumber== null ? 'no disponible' : _user!.phoneNumber!,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
    );
  }
}