import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psmnn/database/database_helper.dart';
import 'package:psmnn/provider/flags_provider.dart';

import '../models/post_model.dart';
import '../widgets/item_post_widget.dart';

class ListPost extends StatefulWidget {
  const ListPost({super.key});

  @override
  State<ListPost> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  DatabaseHelper? databaseHelper;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    flag.getflagListPost();

    return FutureBuilder(
      future: databaseHelper!.GETALLPOST(),
      builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var objPostModel = snapshot.data![index];
              return ItemPostModel(objPostModel: objPostModel);
            },
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Ocurrio un error'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
