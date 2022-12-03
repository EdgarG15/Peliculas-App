import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';
import 'package:peliculas/models/now_playing_response.dart';

import '../models/movie.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = 'd14d5618ceb69d33efa8db4f6b934a4c';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  int _popularPage = 0;

  MoviesProvider() {
    if (kDebugMode) {
      print('MoviesProvider Inicializado');
    }
    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');

    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    //final Map<String, dynamic> decodedData = json.decode(response.body);

    //if (response.statusCode != 200) return print('error');

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(
      _baseUrl,
      endpoint,
      {'api_key': _apiKey, 'language': _language, 'page': '$page'},
    );
    final response = await http.get(url);
    return response.body;
  }

  getPopularMovies() async {
    _popularPage++;

    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    //final Map<String, dynamic> decodedData = json.decode(response.body);

    //if (response.statusCode != 200) return print('error');

    popularMovies = [...popularMovies, ...popularResponse.results];

    ///print(popularMovies[0]);
    notifyListeners();
  }
}
