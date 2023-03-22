import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:psmnn/models/popular_model.dart';

class ApiPopular {
  Uri link = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=131b62e98195229a103c64898e605729&language=es-MX&page=1');

  Future<List<PopularModel>?> getAllPopular() async {
    var result = await http.get(link);
    var listJSON = jsonDecode(result.body)['results'] as List;
    if (result.statusCode == 200) {
      return listJSON.map((popular) => PopularModel.fromMap(popular)).toList();
    }

    return null;
  }
}
