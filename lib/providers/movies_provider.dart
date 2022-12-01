import 'package:flutter/foundation.dart';

class MoviesProvider extends ChangeNotifier {
  MoviesProvider() {
    if (kDebugMode) {
      print('MoviesProvider Inicializado');
    }
    getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    if (kDebugMode) {
      print('getOnDisplayMovies');
    }
  }
}
