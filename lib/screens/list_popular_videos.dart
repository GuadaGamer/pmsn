import 'package:flutter/material.dart';
import 'package:psmnn/models/popular_model.dart';

import '../network/api_popular.dart';
import '../widgets/item_popular.dart';

class ListPopularVideos extends StatefulWidget {
  const ListPopularVideos({super.key});

  @override
  State<ListPopularVideos> createState() => _ListPopularVideosState();
}

class _ListPopularVideosState extends State<ListPopularVideos> {
  ApiPopular? apiPoular;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiPoular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Popular'),
      ),
      body: FutureBuilder(
          future: apiPoular!.getAllPopular(),
          builder: (context, AsyncSnapshot<List<PopularModel>?> snapshop) {
            if (snapshop.hasData) {
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .9,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: snapshop.data != null ? snapshop.data!.length : 0,
                itemBuilder: (context, index) {
                  return ItemPopular(popularModel: snapshop.data![index]);
                },
              );
            } else if (snapshop.hasError) {
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
