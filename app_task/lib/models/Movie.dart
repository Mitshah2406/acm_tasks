class Movie {
  final int id;
  final String title;
  final List<int> genreIds;
  final String overview;
  final String posterPath;

  Movie({
    required this.id,
    required this.title,
    required this.genreIds,
    required this.overview,
    required this.posterPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      genreIds: List<int>.from(json['genre_ids']),
      overview: json['overview'],
      posterPath: json['poster_path'],
    );
  }
}
