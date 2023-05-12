import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:psmnn/database/database_helper.dart';
import 'package:psmnn/models/actor_model.dart';
import 'package:psmnn/models/popular_model.dart';
import 'package:psmnn/network/api_popular.dart';
import 'package:psmnn/provider/flags_provider.dart';
import 'package:psmnn/widgets/item_actor_popular.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetail extends StatelessWidget {
  ApiPopular apiPopular = ApiPopular();
  DatabaseHelper database = DatabaseHelper();

  final PopularModel modelo;
  MovieDetail({Key? key, required this.modelo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: Hero(
        tag: modelo.id!,
        child: SingleChildScrollView(
            child: Column(
          children: [
            inicio(),
            Text(modelo.title.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 20)),
            botonera(context),
            informacion()
          ],
        )),
      ),
    );
  }

  Widget botonera(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FutureBuilder(
              future: database.GETONEPOPULAR(modelo.id!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return InkWell(
                    onTap: () {
                      if (snapshot.data != true) {
                        database
                            .INSERT('tblPopularFav', modelo.toMap())
                            .then((value) {
                          flag.setflagListPost();
                          var msj = value > 0
                              ? 'Se agrego a favoritos'
                              : 'ocurrio un error';

                          var snackBar = SnackBar(content: Text(msj));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      } else {
                        database.DELETEpopular(
                          'tblPopularFav',
                          modelo.id!,
                        ).then((value) {
                          flag.setflagListPost();
                          var msj = value > 0
                              ? 'Se quito de favoritos'
                              : 'ocurrio un error';

                          var snackBar = SnackBar(content: Text(msj));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.star,
                          color:
                              snapshot.data != true ? Colors.white : Colors.red,
                        ),
                        Text(
                          snapshot.data != true
                              ? 'Añadir a favoritos'
                              : 'Quitar de favoritos',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
          TextButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierColor: const Color.fromARGB(117, 65, 63, 63),
                  builder: (context) {
                    return showTeaserVideo(modelo.id!);
                  },
                );
              },
              style: TextButton.styleFrom(backgroundColor: Colors.white),
              icon: const Icon(
                Icons.play_arrow,
                color: Colors.black,
              ),
              label: const Text(
                'Reproducir',
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
    );
  }

  Widget inicio() {
    return Stack(
      children: [
        Image.network(
          'https://image.tmdb.org/t/p/w500/${modelo.backdropPath}',
          height: 400,
          fit: BoxFit.fill,
        ),
        Container(
          width: double.infinity,
          height: 400,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color.fromARGB(30, 0, 0, 0), Colors.black])),
        ),
        SafeArea(
          child: Container(),
        )
      ],
    );
  }

  Widget informacion() {
    return Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: NetworkImage('https://image.tmdb.org/t/p/w500/${modelo!.backdropPath}'),
        //     fit: BoxFit.cover,
        //     colorFilter:
        //         const ColorFilter.mode(Colors.black, BlendMode.softLight),
        //   ),
        // ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              modelo.title.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar(
                  initialRating: modelo.voteAverage! / 2,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                      full: const Icon(Icons.star, color: Colors.orange),
                      half: const Icon(
                        Icons.star_half,
                        color: Colors.orange,
                      ),
                      empty: const Icon(
                        Icons.star_outline,
                        color: Colors.orange,
                      )),
                  ignoreGestures: true,
                  onRatingUpdate: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              'Sinopsis',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              modelo.overview.toString(),
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 40),
            const Text(
              'Actores',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<ActorModel>?>(
              future: apiPopular.getAllActors(modelo!),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        ActorModel actor = snapshot.data![index];
                        return CardActor(
                          name: actor.name.toString(),
                          photoUrl: actor.profilePath != null
                              ? 'https://image.tmdb.org/t/p/original${actor.profilePath}'
                              : 'https://www.personality-insights.com/wp-content/uploads/2017/12/default-profile-pic-e1513291410505.jpg',
                          character: actor.character!,
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ));
  }

  showTeaserVideo(int id_popular) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: FutureBuilder(
          future: apiPopular.getVideo(id_popular),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return YoutubePlayer(
                controller: YoutubePlayerController(
                    initialVideoId: snapshot.data.toString(),
                    flags: const YoutubePlayerFlags(
                      autoPlay: true,
                      mute: false,
                      controlsVisibleAtStart: false,
                    )),
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.red,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
