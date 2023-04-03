import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:psmnn/models/actor_model.dart';
import 'package:psmnn/models/popular_model.dart';

class ApiPopular {
  Uri link = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=89dbf5270b59edd2f28730765b489b9e&language=es-MX&page=1');

  Future<List<PopularModel>?> getAllPopular() async {
    var result = await http.get(link);
    var listJSON = jsonDecode(result.body)['results'] as List;
    if (result.statusCode == 200) {
      return listJSON.map((popular) => PopularModel.fromMap(popular)).toList();
    }

    return null;
  }

  Future<String> getVideo(int id_popular)async{
    Uri linkES = Uri.parse(
      'https://api.themoviedb.org/3/movie/$id_popular/videos?api_key=d7236b730825fb7b3c7e23e7d91e473c&language=es-MX');
    Uri linkEN = Uri.parse(
      'https://api.themoviedb.org/3/movie/$id_popular/videos?api_key=d7236b730825fb7b3c7e23e7d91e473c');
    var result = await http.get(linkES);
    var listJSON = jsonDecode(result.body)['results'] as List;
    if (listJSON.isEmpty){
      result = await http.get(linkEN);
      listJSON = jsonDecode(result.body)['results'] as List;
    }
    if(result.statusCode==200){
      for (var element in listJSON) {
        if(element['type']=='Trailer'){
          return element['key'];
        }
      }
    }
    return '';
  }

  Future<List<ActorModel>?> getAllActors(PopularModel popularModel) async{
    Uri link= Uri.parse('https://api.themoviedb.org/3/movie/${popularModel.id}/credits?api_key=d7236b730825fb7b3c7e23e7d91e473c');
    var result = await http.get(link);
    var listJSON = jsonDecode(result.body)['cast'] as List;
    if(result.statusCode==200){
      return listJSON.map((actor) => ActorModel.fromMap(actor)).toList();
    }
    return null;
  }
}
