import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psmnn/database/database_helper.dart';
import 'package:psmnn/models/post_model.dart';

import '../provider/flags_provider.dart';

class ItemPostModel extends StatelessWidget {
  ItemPostModel({super.key, this.objPostModel});

  PostModel? objPostModel;

  DatabaseHelper database = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    final avatar = const CircleAvatar(
      backgroundImage: AssetImage('assets/profile.png'),
    );

    final txtUser = const Text('Texto');
    final datePost = Text(objPostModel!.datePost!.toString());

    final imgPost = Image(
      image: AssetImage('assets/lince.png'),
      width: 100,
      height: 100,
    );
    final txtDescPost = Text(objPostModel!.dscPost!);
    final iconRate = const Icon(Icons.star_rate_sharp);

    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    return Container(
      margin: const EdgeInsets.all(10),
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
          Row(
            children: [
              iconRate,
              Expanded(child: Container()),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add',
                        arguments: objPostModel);
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          title: const Text('Confirmar borrado'),
                          content: const Text('Deseas borrar el post?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  database
                                      .DELETE('tblPost', objPostModel!.idPost!)
                                      .then((value) => flag.setflagListPost());
                                  Navigator.pop(context);
                                },
                                child: const Text('Si')),
                            TextButton(
                                onPressed: () {}, child: const Text('No'))
                          ]),
                    );
                  },
                  icon: const Icon(Icons.delete))
            ],
          ),
        ],
      ),
    );
  }
}
