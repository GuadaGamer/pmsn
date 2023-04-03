import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psmnn/database/database_helper.dart';
import 'package:psmnn/models/popular_model.dart';
import 'package:psmnn/provider/flags_provider.dart';
import 'package:psmnn/screens/movie_detail_Screen.dart';

import '../network/api_popular.dart';
import '../widgets/item_popular.dart';

class ListPopularVideos extends StatefulWidget {
  const ListPopularVideos({super.key});

  @override
  State<ListPopularVideos> createState() => _ListPopularVideosState();
}

class _ListPopularVideosState extends State<ListPopularVideos> {
  ApiPopular? apiPoular;
  DatabaseHelper? database;
  bool favoritView = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiPoular = ApiPopular();
    database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('List Popular'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                favoritView = !favoritView;
              });
            }, 
            icon: favoritView==true? const Icon(Icons.list_outlined) : const Icon(Icons.hotel_class_rounded))
        ],
      ),
      body: FutureBuilder(
          future: flag.getflagListPost() == true
          ? favoritView
            ? database!.GETALLPOPULAR()
            : apiPoular!.getAllPopular()
          : favoritView
            ? database!.GETALLPOPULAR()
            : apiPoular!.getAllPopular(),
          builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .7,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: snapshot.data != null ? snapshot.data!.length : 0,
                itemBuilder: (context, index) {
                  PopularModel model = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder:(BuildContext context) => MovieDetail(modelo: model) ));
                    },
                    child: ItemPopular(popularModel: snapshot.data![index]),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Ocurrio un error'),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
