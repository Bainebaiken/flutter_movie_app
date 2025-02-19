import 'package:flutter/material.dart';
import '../services/movie_service.dart';
import '../models/movie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies App'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: MovieService().fetchPopularMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No popular movies found'));
          }

          final movies = snapshot.data!;

          return SizedBox(
            height: 250, // Adjust height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // ✅ Makes the list horizontal
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: movie.posterPath != null
                            ? Image.network(
                                'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                                width: 120, // ✅ Adjust width
                                height: 180, // ✅ Adjust height
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.movie, size: 120),
                              )
                            : const Icon(Icons.movie, size: 120),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 120,
                        child: Text(
                          movie.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}









// import 'package:flutter/material.dart';

// import '../services/movie_service.dart';
// import '../models/movie.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Movies App'),
//       ),
//       body: FutureBuilder<Movie?>(
//         future: MovieService().fetchLatestMovies(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data == null) {
//             return const Center(child: Text('No latest movie found'));
//           }
         
//           final movie = snapshot.data!;
//           return ListTile(
//             leading: movie.posterPath != null
//                 ? Image.network('https://image.tmdb.org/t/p/w200${movie.posterPath}')
//                 : const Icon(Icons.movie),
//             title: Text(movie.title),
//             subtitle: Text('Rating: ${movie.voteAverage?.toStringAsFixed(1) ?? 'N/A'}'),
//             onTap: () {
//               // Navigate to movie details
//             },
//           );
//         },
//       ),
//     );
//   }
// }
