import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/genre.dart';
import '../models/movie.dart';

// Replace with your TMDb API key
const String apiKey = 'f11a4ef31954020803bde4c622fb7ed0';
const String baseUrl = 'https://api.themoviedb.org/3';

class MovieService {
  // Fetch popular movies
  Future<List<Movie>> fetchPopularMovies() async {
    final url = Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&language=en-US');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final jsonResults = data['results'];
        if (jsonResults == null) throw Exception('Invalid API response');

        return (jsonResults as List)
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList();
      } else {
        throw Exception('Failed to load popular movies');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch latest movie (single movie)
  Future<Movie?> fetchLatestMovie() async {
    final url = Uri.parse('$baseUrl/movie/latest?api_key=$apiKey&language=en-US');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Movie.fromJson(data);
      } else {
        throw Exception('Failed to load latest movie');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch now playing movies (alternative to latest)
  Future<List<Movie>> fetchNowPlayingMovies() async {
    final url = Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey&language=en-US');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final jsonResults = data['results'];
        if (jsonResults == null) throw Exception('Invalid API response');

        return (jsonResults as List)
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList();
      } else {
        throw Exception('Failed to load now playing movies');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch movie genres
  Future<List<Genre>> fetchGenres() async {
    final url = Uri.parse('$baseUrl/genre/movie/list?api_key=$apiKey&language=en-US');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final jsonGenres = data['genres'];
        if (jsonGenres == null) throw Exception('Invalid API response');

        return (jsonGenres as List)
            .map((genreJson) => Genre.fromJson(genreJson))
            .toList();
      } else {
        throw Exception('Failed to load genres');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch movie details (with credits & reviews)
  Future<Movie> fetchMovieDetails(int movieId) async {
    final url = Uri.parse(
        '$baseUrl/movie/$movieId?api_key=$apiKey&language=en-US&append_to_response=credits,reviews');
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
