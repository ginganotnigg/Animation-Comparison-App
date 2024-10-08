import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/movie.dart';

class MaterialMotionScreen extends StatefulWidget {
  final bool useBuiltIn;

  const MaterialMotionScreen({super.key, required this.useBuiltIn});

  @override
  State<MaterialMotionScreen> createState() => _MaterialMotionScreenState();
}

class _MaterialMotionScreenState extends State<MaterialMotionScreen> {
  final List<Movie> movies = sampleMovies();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Material Motion Comparison'),
        ),
        body: widget.useBuiltIn
            ? builtInView(movies, context)
            : libraryView(movies, context));
  }

  Widget movieDetailsView(Movie movie) {
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
            ],
          ),
        ),
      ),
    );
  }

  Widget movieCardView(Movie movie) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(movie.title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text(
              movie.description,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget builtInView(List<Movie> movies, BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return Hero(
          tag: movies[index].title,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return Scaffold(
                        appBar: AppBar(
                          title: Text(movies[index].title,
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        body: Hero(
                            tag: movies[index].title,
                            child: movieDetailsView(movies[index])));
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
            },
            child: movieCardView(movies[index]),
          ),
        );
      },
    );
  }

  Widget libraryView(List<Movie> movies, BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return OpenContainer(
          transitionType: ContainerTransitionType.fadeThrough,
          openBuilder: (context, closedContainer) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(movies[index].title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                body: movieDetailsView(movies[index]));
          },
          closedBuilder: (context, openContainer) {
            return GestureDetector(
              onTap: openContainer as GestureTapCallback?,
              child: movieCardView(movies[index]),
            );
          },
        );
      },
    );
  }
}
