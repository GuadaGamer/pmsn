import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psmnn/responsive.dart';

import '../provider/theme_provider.dart';

class ThemeSelectorScreen extends StatelessWidget {
  const ThemeSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona un tema'),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/fondo.webp',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Responsive(
            mobile: buildMobileLayout(theme, context),
            desktop: buildDesktopLayout(theme, context),
          ),
        ],
      ),
    );
  }

  Widget buildMobileLayout(ThemeProvider theme, BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Seleccione un tema',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            OutlinedButton(
              onPressed: () {
                theme.setthemeData(0, context);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color.fromRGBO(17, 117, 51, 1), shape: const StadiumBorder(),
                side: const BorderSide(width: 2, color: Color.fromRGBO(17, 117, 51, 1)),
              ),
              child: const Text(
                'Tema claro',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                theme.setthemeData(2, context);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color.fromRGBO(27, 57, 106, 1), shape: const StadiumBorder(),
                side: const BorderSide(width: 2, color: Color.fromRGBO(27, 57, 106, 1)),
              ),
              child: const Text(
                'Tema personalizado',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                theme.setthemeData(1, context);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color.fromRGBO(0, 0, 0, 1), shape: const StadiumBorder(),
                side: const BorderSide(width: 2, color: Color.fromRGBO(0, 0, 0, 1)),
              ),
              child: const Text('Tema oscuro',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/dash');
                    },
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: const Color.fromRGBO(17, 117, 51, 1),
                      side: const BorderSide(width: 2, color: Color.fromRGBO(17, 117, 51, 1)),
                    ),
                    child: const Text(
                      'Guardar',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      theme.setthemeData(0, context);
                      Navigator.pushNamed(context, '/dash');
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 255, 0, 0), shape: const StadiumBorder(),
                      side: const BorderSide(width: 2, color: Color.fromARGB(255, 255, 0, 0)),
                    ),
                    child: const Text('Cancelar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDesktopLayout(ThemeProvider theme, BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/fondo.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          width: 600,
          height: 500,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Seleccione un tema',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      theme.setthemeData(0, context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(17, 117, 51, 1), shape: const StadiumBorder(),
                      side: const BorderSide(width: 2, color: Color.fromRGBO(17, 117, 51, 1)),
                    ),
                    child: const Text(
                      'Tema claro',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      theme.setthemeData(2, context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(27, 57, 106, 1), shape: const StadiumBorder(),
                      side: const BorderSide(width: 2, color: Color.fromRGBO(27, 57, 106, 1)),
                    ),
                    child: const Text(
                      'Tema personalizado',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      theme.setthemeData(1, context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(0, 0, 0, 1), shape: const StadiumBorder(),
                      side: const BorderSide(width: 2, color: Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    child: const Text('Tema oscuro',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/dash');
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(17, 117, 51, 1), shape: const StadiumBorder(),
                      side: const BorderSide(width: 2, color: Color.fromRGBO(17, 117, 51, 1)),
                    ),
                    child:const  Text(
                      'Guardar',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      theme.setthemeData(0, context);
                      Navigator.pushNamed(context, '/dash');
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 255, 0, 0), shape: const StadiumBorder(),
                      side: const BorderSide(width: 2, color: Color.fromARGB(255, 255, 0, 0)),
                    ),
                    child: const Text('Cancelar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}