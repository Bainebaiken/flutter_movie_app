import 'package:flutter/material.dart';
import 'package:movie_app/services/api_service.dart';

import 'movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Movie?> latestMovie;

  @override
  void initState() {
    super.initState();
    latestMovie = ApiService.fetchLatestMovie() as Future<Movie?>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Latest Movie')),
      body: Center(
        child: FutureBuilder<Movie?>(
          future: latestMovie,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError || snapshot.data == null) {
              return const Text('Failed to load movie');
            }

            Movie movie = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(movie.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                movie.posterPath!.isNotEmpty
                    ? Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}')
                    : const Text('No image available'),
                const SizedBox(height: 10),
                Text('Release Date: ${movie.releaseDate}'),
                Text('Rating: ${movie.rating.toString()}'),
              ],
            );
          },
        ),
      ),
    );
  }
}
