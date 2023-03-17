import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psmnn/database/database_helper.dart';
import 'package:psmnn/models/post_model.dart';

import '../provider/flags_provider.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});

  DatabaseHelper database = DatabaseHelper();

  PostModel? objPosmodel;

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    final txtContPost = TextEditingController();

    if (ModalRoute.of(context)!.settings.arguments != null) {
      objPosmodel = ModalRoute.of(context)!.settings.arguments as PostModel;
      txtContPost.text = objPosmodel!.dscPost!;
    }

    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(15),
          height: 350,
          decoration: BoxDecoration(
              color: Colors.greenAccent,
              border: Border.all(color: Colors.black)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              objPosmodel == null
                  ? const Text('Add Post')
                  : const Text('Update post'),
              TextFormField(
                controller: txtContPost,
                maxLines: 8,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (objPosmodel == null) {
                      database.INSERT('tblPost', {
                        'dscPost': txtContPost.text,
                        'datePost': DateTime.now().toString()
                      }).then((value) {
                        var msj = value > 0
                            ? 'Registro insertado'
                            : 'ocurrio un error';

                        var snackBar = SnackBar(content: Text(msj));

                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    } else {
                      database.UPDATE('tblPost', {
                        'idPost': objPosmodel!.idPost,
                        'dscPost': txtContPost.text,
                        'datePost': DateTime.now().toString()
                      }).then((value) {
                        var msj = value > 0
                            ? 'Registro actualizado'
                            : 'ocurrio un error';

                        var snackBar = SnackBar(content: Text(msj));
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    }
                    flag.setflagListPost();
                  },
                  child: const Text('Save post'))
            ],
          ),
        ),
      ),
    );
  }
}
