import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psmnn/database/database_helper.dart';
import 'package:psmnn/firebase/favorites_firebase.dart';
import 'package:psmnn/models/popular_model.dart';
import 'package:psmnn/provider/flags_provider.dart';

class ItemPopular extends StatefulWidget {
  const ItemPopular({super.key, required this.popularModel});

  final PopularModel popularModel;

  @override
  State<ItemPopular> createState() => _ItemPopularState();
}

class _ItemPopularState extends State<ItemPopular> {
  FavoritesFirebase _firebase = FavoritesFirebase();
  DatabaseHelper database = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    return Stack(
      children: [
        ClipRRect(
          child: FadeInImage(
            fit: BoxFit.fitWidth,
            placeholder: const AssetImage('assets/loading_tetris.gif'),
            image: NetworkImage(
                'https://image.tmdb.org/t/p/w500/${widget.popularModel.posterPath}'),
          ),
        ),
        Positioned(
            top: 0,
            right: 0,
            child: FutureBuilder(
                future: database.GETONEPOPULAR(widget.popularModel.id!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return IconButton(
                      icon: const Icon(
                        Icons.star,
                        size: 30,
                      ),
                      color: snapshot.data != true
                          ? Colors.greenAccent
                          : Colors.red,
                      onPressed: () {
                        if (snapshot.data != true) {
                          _firebase.insFavorite(
                            {
                              'titulo': widget.popularModel.title,
                              'poster_path': widget.popularModel.posterPath,
                              'vote_count': widget.popularModel.voteAverage,
                              'overview': widget.popularModel.overview,
                            }
                          );
                          database
                              .INSERT(
                                  'tblPopularFav', widget.popularModel.toMap())
                              .then((value) {
                            flag.setflagListPost();
                            var msj = value > 0
                                ? 'Se agrego a favoritos'
                                : 'ocurrio un error';

                            var snackBar = SnackBar(content: Text(msj));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        } else {
                          database.DELETEpopular(
                            'tblPopularFav',
                            widget.popularModel.id!,
                          ).then((value) {
                            flag.setflagListPost();
                            var msj = value > 0
                                ? 'Se quito de favoritos'
                                : 'ocurrio un error';

                            var snackBar = SnackBar(content: Text(msj));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        }
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })),
      ],
    );
  }
}
