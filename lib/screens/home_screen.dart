import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:psmnn/screens/cards/card_tec.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final data = [
    CardTecData(
        title: "TecNM en Celaya",
        subtitle: "¡Orgullosamente, LINCES!",
        image: const AssetImage('assets/itce.png'),
        backgraundColor: const Color.fromARGB(255, 43, 120, 129),
        titleColor: Colors.pink,
        subtitleColor: Colors.white,
        backgraund: Lottie.asset('assets/animation/bg-5.json')),
    CardTecData(
        title: "Misión",
        subtitle: "Contribuir a la transformación de la sociedad a través de la formación de ciudadanas y ciudadanos libres y responsables",
        image: const AssetImage('assets/mision.png'),
        backgraundColor: const Color.fromARGB(255, 17, 148, 139),
        titleColor: Colors.green,
        subtitleColor: Colors.black,
        backgraund: Lottie.asset('assets/animation/bg-2.json')),
    CardTecData(
        title: "Visión",
        subtitle: "Ser una institución de educación superior tecnológica reconocida a nivel internacional por el destacado dersempeño de sus egresadas y egresados",
        image: const AssetImage('assets/vision.png'),
        backgraundColor: const Color.fromARGB(255, 102, 74, 114),
        titleColor: Colors.white,
        subtitleColor: Colors.blue,
        backgraund: Lottie.asset('assets/animation/bg-11.json')),
    CardTecData(
      title: "Ingresa a la red social",
      subtitle: "Presiona el botón para inciar sesión",
      image: const AssetImage('assets/lince.png'),
      backgraundColor: const Color.fromARGB(255, 137, 19, 60),
      titleColor: Colors.pink,
      subtitleColor: Colors.white,
      backgraund: Lottie.asset("assets/animation/bg-3.json")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgraundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index) {
          return CardTec(data: data[index]);
        },
        onFinish: () {
          Navigator.pushNamed(context, '/login');
        },
      ),
    );
  }
}
