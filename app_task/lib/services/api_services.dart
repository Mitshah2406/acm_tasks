import 'dart:convert';
import 'package:app_task/constants/app_constants.dart';
import 'package:app_task/models/Movie.dart';

import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<Movie>> fetchMovies() async {
    print("here");
    final response = await http.get(Uri.parse(AppConstants.moviesApi),
        headers: {"Authorization": "Bearer ${AppConstants.api_key}"});

    print(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      return results.map((movieData) => Movie.fromJson(movieData)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
