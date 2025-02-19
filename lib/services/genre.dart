import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/genre.dart'; // Import the Genre model


// Replace with your TMDb API key
const String apiKey = 'f11a4ef31954020803bde4c622fb7ed0';
const String baseUrl = 'https://api.themoviedb.org/3';

// The GenreService class handles fetching genre-related data
class GenreService {
  // Fetch genres from the API
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

  // Fetch a single genre by its ID (if needed)
  Future<Genre> fetchGenreById(int genreId) async {
    final url = Uri.parse('$baseUrl/genre/$genreId?api_key=$apiKey');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Genre.fromJson(data);
      } else {
        throw Exception('Failed to load genre by ID');
      }
    } catch (e) {
      rethrow;
    }
  }
}
