import 'package:flutter/material.dart';
import 'package:psmnn/firebase/favorites_firebase.dart';

class ListFavoritesCloud extends StatefulWidget {
  const ListFavoritesCloud({super.key});

  @override
  State<ListFavoritesCloud> createState() => _ListFavoritesCloudState();
}

class _ListFavoritesCloudState extends State<ListFavoritesCloud> {
  FavoritesFirebase _firebase = FavoritesFirebase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          stream: _firebase.getAllFavorites(),
          builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Text(snapshot.data!.docs[index].get('titulo')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.favorite)),
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                  title: const Text('Confirmar borrado'),
                                  content:
                                      const Text('Deseas borrar el favorito?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          _firebase.delFavorite(
                                              snapshot.data!.docs[index].id);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Si')),
                                    TextButton(
                                        onPressed: () {},
                                        child: const Text('No'))
                                  ]),
                            );
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                  ClipRRect(
                    child: FadeInImage(
                      fit: BoxFit.fitWidth,
                      placeholder:
                          const AssetImage('assets/loading_tetris.gif'),
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500${snapshot.data!.docs[index].get('poster_path')}'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star),
                      Text("${snapshot.data!.docs[index].get('vote_count')}"),
                    ],
                  ),
                  Text(snapshot.data!.docs[index].get('overview')),
                ],
              );
              /* return Stack(
                children: [
                  Column(
                    children: [
                      Text(snapshot.data!.docs[index].get('titulo')),
                  ClipRRect(
                    child: FadeInImage(
                      fit: BoxFit.fitWidth,
                      placeholder:
                          const AssetImage('assets/loading_tetris.gif'),
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500${snapshot.data!.docs[index].get('poster_path')}'),
                    ),
                  ),
                  Row(children: [
                    const Icon(Icons.star),
                    Text("${snapshot.data!.docs[index].get('vote_count')}"),
                  ],),
                  Text(snapshot.data!.docs[index].get('overview'))
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Row(
                      children: [
                        const Icon(Icons.change_circle),
                        Expanded(child: Container()),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                    title: const Text('Confirmar borrado'),
                                    content:
                                        const Text('Deseas borrar el post?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {},
                                          child: const Text('Si')),
                                      TextButton(
                                          onPressed: () {},
                                          child: const Text('No'))
                                    ]),
                              );
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  ),
                ],
              );*/
            },
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error en la petición, intente nuevamente'),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    ));
  }
}
