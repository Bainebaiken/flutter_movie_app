import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie.dart';

class ApiService {
  static const String _apiKey = 'f11a4ef31954020803bde4c622fb7ed0'; // Replace with your key
  static const String _baseUrl = 'https://api.themoviedb.org/3/movie/latest';

  static Future<Movie?> fetchLatestMovie() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl?api_key=$_apiKey'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Movie.fromJson(jsonData);
      } else {
        throw Exception('Failed to load latest movie');
      }
    } catch (e) {
      if (kDebugMode) {
        if (kDebugMode) {
          print('Error: $e');
        }
      }
      return null;
    }
  }
}
