import '../screen/trailer.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/movie.dart';

class ComplexLoadingScreen extends StatefulWidget {
  final bool useBuiltIn;

  const ComplexLoadingScreen({super.key, required this.useBuiltIn});

  @override
  State<ComplexLoadingScreen> createState() => _ComplexLoadingScreenState();
}

class _ComplexLoadingScreenState extends State<ComplexLoadingScreen> {
  final Movie movie = sampleMovies()[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Complex Loading Comparison'),
        ),
        body: movieDetailsView(movie, context));
  }

  Widget movieDetailsView(Movie movie, context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: movie.imageUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(height: 10),
              Text(
                "Release date: ${movie.releaseDate}",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              Text(
                movie.description,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Navigate to trailer screen with loading animation
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TrailerScreen(
                            useBuiltIn: widget.useBuiltIn, movie: movie)),
                  );
                },
                child: const Text('Watch Trailer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget builtInView(List<Movie> movies, BuildContext context) {
    return const Scaffold();
  }

  Widget libraryView(List<Movie> movies, BuildContext context) {
    return const Scaffold();
  }
}
