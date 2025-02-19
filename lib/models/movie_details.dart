import 'package:movie_app/cast.dart';
import 'package:movie_app/models/crew.dart';
import 'package:movie_app/models/genre.dart';
import 'package:movie_app/models/image.dart';
import 'package:movie_app/models/production_company.dart';
import 'package:movie_app/models/review.dart';
import 'package:movie_app/models/video.dart';


class MovieDetail {
  final int id;
  final String title;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final double? voteAverage;
  final int? voteCount;
  final String? releaseDate;
  final List<Genre> genres;
  final List<ProductionCompany> productionCompanies;
  final List<Cast> cast;
  final List<Crew> crew;
  final List<Video> videos;
  final List<MovieImage> images;
  final List<Review> reviews;

  MovieDetail({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.voteCount,
    this.releaseDate,
    required this.genres,
    required this.productionCompanies,
    required this.cast,
    required this.crew,
    required this.videos,
    required this.images,
    required this.reviews,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'],
      releaseDate: json['release_date'],
      genres: (json['genres'] as List).map((g) => Genre.fromJson(g)).toList(),
      productionCompanies: (json['production_companies'] as List)
          .map((p) => ProductionCompany.fromJson(p))
          .toList(),
      cast: (json['credits']['cast'] as List)
          .map((c) => Cast.fromJson(c))
          .toList(),
      crew: (json['credits']['crew'] as List)
          .map((c) => Crew.fromJson(c))
          .toList(),
      videos: (json['videos']['results'] as List)
          .map((v) => Video.fromJson(v))
          .toList(),
      images: (json['images']['backdrops'] as List)
          .map((i) => MovieImage.fromJson(i))
          .toList(),
      reviews: (json['reviews']['results'] as List)
          .map((r) => Review.fromJson(r))
          .toList(),
    );
  }
}
