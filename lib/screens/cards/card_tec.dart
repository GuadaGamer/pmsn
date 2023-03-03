import 'package:flutter/material.dart';

class CardTecData {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color backgraundColor;
  final Color titleColor;
  final Color subtitleColor;

  const CardTecData({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.backgraundColor,
    required this.titleColor,
    required this.subtitleColor,
  });
}

class CardTec extends StatelessWidget {
  const CardTec({required this.data, super.key});

  final CardTecData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: data.image),
        Text(
          data.title.toUpperCase(),
          style: TextStyle(
            color: data.titleColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        )
      ],
    );
  }
}
