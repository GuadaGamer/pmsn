import 'package:flutter/material.dart';
import 'package:psmnn/models/post_model.dart';

class ItemPostModel extends StatelessWidget {
  ItemPostModel({super.key, this.objPostModel});

  PostModel? objPostModel;

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      backgroundImage: AssetImage('assets/profile.png'),
    );

    final txtUser = Text('Texto');
    final datePost = Text('06/03/2023');

    final imgPost = Image(image: AssetImage('assets/lince.png'));
    final txtDescPost = Text('Descripcion mamalona sobre esta madre');
    final iconRate = Icon(Icons.star_rate_sharp);

    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
          color: Colors.greenAccent, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            children: [avatar, txtUser, datePost],
          ),
          Row(
            children: [imgPost, txtDescPost],
          ),
          iconRate
        ],
      ),
    );
  }
}
