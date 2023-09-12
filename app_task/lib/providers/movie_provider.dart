import 'package:app_task/models/Movie.dart';
import 'package:app_task/services/api_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieProvider = FutureProvider<List<Movie>>((ref) async {
  return ApiServices().fetchMovies();
});
