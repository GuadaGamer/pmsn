import 'package:flutter/material.dart';
import 'package:psmnn/database/database_helper.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});

  DatabaseHelper database = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    final txtContPost = TextEditingController();

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
              const Text('Add Post'),
              TextFormField(
                controller: txtContPost,
                maxLines: 8,
              ),
              ElevatedButton(
                  onPressed: () {
                    database.INSERT('tblPost', {
                      'dscPost': txtContPost.text,
                      'datePost': DateTime.now().toString()
                    }).then((value) {
                      var msj =
                          value > 0 ? 'Registro insertado' : 'ocurrio un error';

                      var snackBar = SnackBar(content: Text(msj));

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  },
                  child: const Text('Save post'))
            ],
          ),
        ),
      ),
    );
  }
}
