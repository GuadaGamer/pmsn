import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:psmnn/screens/cards/card_tec.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  final data = const [
    CardTecData(
        title: "Num 1",
        subtitle: "primera parte",
        image: AssetImage('assets/itce.png'),
        backgraundColor: Color.fromARGB(0, 10, 56, 1),
        titleColor: Colors.pink,
        subtitleColor: Colors.white),
    CardTecData(
        title: "Num 2",
        subtitle: "segunda parte",
        image: AssetImage('assets/mision.png'),
        backgraundColor: Color.fromARGB(146, 63, 192, 37),
        titleColor: Colors.green,
        subtitleColor: Colors.black),
    CardTecData(
        title: "Num 3",
        subtitle: "tercera parte",
        image: AssetImage('assets/vision.png'),
        backgraundColor: Color.fromARGB(120, 57, 27, 141),
        titleColor: Colors.white,
        subtitleColor: Colors.blueGrey)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgraundColor).toList(),
        itemBuilder: (int index) {
          return CardTec(data: data[index]);
        },
      ),
    );
  }
}
