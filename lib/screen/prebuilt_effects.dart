import 'package:animation_app/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PreBuiltEffectScreen extends StatefulWidget {
  final bool useBuiltIn;

  const PreBuiltEffectScreen({Key? key, required this.useBuiltIn})
      : super(key: key);

  @override
  _PreBuiltEffectScreenState createState() => _PreBuiltEffectScreenState();
}

class _PreBuiltEffectScreenState extends State<PreBuiltEffectScreen>
    with SingleTickerProviderStateMixin {
  final List<Movie> movies = sampleMovies();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pre Built Effects Comparison')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return widget.useBuiltIn
                ? _buildBuiltInPreBuiltEffects(movie, index)
                : _buildFlutterAnimatePreBuiltEffects(movie);
          },
        ),
      ),
    );
  }

  Widget _movieTile(Movie movie) {
    return Container(
      width: double.infinity,
      height: 120,
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: FadeInImage.assetNetwork(
          placeholder: 'lib/assets/images/default.png',
          image: movie.imageUrl,
          width: 80,
          fit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.broken_image,
              size: 80,
            );
          },
        ),
        title: Text(movie.title),
        subtitle: Text('Release: ${movie.releaseDate}'),
      ),
    );
  }

  Widget _buildBuiltInPreBuiltEffects(Movie movie, int index) {
    // Create animations for each movie tile
    final animationDelay = 100 * index; // Increment delay based on index
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _controller.value,
          child: Transform.translate(
            offset: Offset(
              0,
              (1 - _controller.value) * 20, // Slide effect
            ),
            child: Transform.scale(
              scale: 1 + (_controller.value * 0.1), // Scale effect
              child: child,
            ),
          ),
        );
      },
      child: _movieTile(movie),
    );
  }

  Widget _buildFlutterAnimatePreBuiltEffects(Movie movie) {
    return _movieTile(movie)
        .animate()
        .fadeIn(duration: 500.ms)
        .then(delay: 100.ms)
        .slide()
        .scale()
        .move(delay: 200.ms, duration: 200.ms);
  }
}
