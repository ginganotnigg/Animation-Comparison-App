import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../model/movie.dart';
import '../model/loader.dart';

class TrailerScreen extends StatelessWidget {
  final bool useBuiltIn;
  final Movie movie;

  const TrailerScreen(
      {super.key, required this.movie, required this.useBuiltIn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${movie.title} Trailer'),
      ),
      body: FutureBuilder(
        future: _loadTrailer(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display loading animation
            return Center(
              child: useBuiltIn
                  ? const Loader()
                  : Lottie.asset('lib/assets/loading.json',
                      width: 200, height: 200),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading trailer.'));
          } else {
            // Replace this with actual YouTube player widget
            return const Center(child: Text('Trailer Loaded!')); // Placeholder
          }
        },
      ),
    );
  }

  Future<void> _loadTrailer() async {
    // Simulate a network request or loading process
    await Future.delayed(const Duration(seconds: 3));
  }
}
