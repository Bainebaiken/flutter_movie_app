import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/genre.dart';
import 'package:movie_app/movie.dart';

// import 'package:flutter/foundation.dart';

// Replace with your TMDb API key
const String apiKey = 'f11a4ef31954020803bde4c622fb7ed0';
const String baseUrl = 'https://api.themoviedb.org/3';

// The MovieService class handles fetching data
class MovieService {
  // Fetch popular movies
  Future<List<Movie>> fetchPopularMovies() async {
    final url = Uri.parse('$baseUrl/movie/popular?api_key=$apiKey');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Movie> popularMovies = (data['results'] as List)
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList();
        return popularMovies;
      } else {
        throw Exception('Failed to load popular movies');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch latest movies
  Future<List<Movie>> fetchLatestMovies() async {
    final url = Uri.parse('$baseUrl/movie/latest?api_key=$apiKey');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        Movie latestMovie = Movie.fromJson(data);
        return [latestMovie]; // Return as a list for uniformity
      } else {
        throw Exception('Failed to load latest movie');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch genres
  Future<List<Genre>> fetchGenres() async {
    final url = Uri.parse('$baseUrl/genre/movie/list?api_key=$apiKey');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Genre> genres = (data['genres'] as List)
            .map((genreJson) => Genre.fromJson(genreJson))
            .toList();
        return genres;
      } else {
        throw Exception('Failed to load genres');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch movie details by ID (for actors, reviews, etc.)
  Future<Movie> fetchMovieDetails(int movieId) async {
    final url = Uri.parse('$baseUrl/movie/$movieId?api_key=$apiKey');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Movie.fromJson(data);
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      rethrow;
    }
  }
}
