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
        backgraundColor: const Color.fromARGB(171, 10, 56, 1),
        titleColor: Colors.pink,
        subtitleColor: Colors.white,
        backgraund: Lottie.asset('assets/animation/bg-7.json')),
    CardTecData(
        title: "Misión",
        subtitle: "Contribuir a la transformación de la sociedad a través de la formación de ciudadanas y ciudadanos libres y responsables",
        image: const AssetImage('assets/mision.png'),
        backgraundColor: const Color.fromARGB(146, 63, 192, 37),
        titleColor: Colors.green,
        subtitleColor: Colors.black,
        backgraund: Lottie.asset('assets/animation/bg-2.json')),
    CardTecData(
        title: "Visión",
        subtitle: "Ser una institución de educación superior tecnológica reconocida a nivel internacional por el destacado desempeño de sus egresadas y egresados",
        image: const AssetImage('assets/vision.png'),
        backgraundColor: const Color.fromARGB(120, 57, 27, 141),
        titleColor: Colors.white,
        subtitleColor: Colors.blueGrey,
        backgraund: Lottie.asset('assets/animation/bg-11.json'))
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
