import 'package:flutter/material.dart';

class CardActor extends StatelessWidget {
  final String name;
  final String photoUrl;
  final String character;

  const CardActor({
    Key? key,
    required this.name,
    required this.photoUrl,
    required this.character
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          ClipOval(
            child: Image.network(
              photoUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'como: $character',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
        ],
      ),
    );
  }
}