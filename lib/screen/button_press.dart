import 'package:animation_app/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;

class ButtonPressScreen extends StatefulWidget {
  final bool useBuiltIn;

  const ButtonPressScreen({Key? key, required this.useBuiltIn})
      : super(key: key);

  @override
  _ButtonPressScreenState createState() => _ButtonPressScreenState();
}

class _ButtonPressScreenState extends State<ButtonPressScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  List<Movie> _searchResults = [];
  rive.SMITrigger? _onClick;
  double _scale = 1.0;
  double _shadowBlur = 0.0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchMovies() async {
    setState(() {
      _searchResults = [];
    });

    String query = _searchController.text.toLowerCase();

    List<Movie> results = sampleMovies()
        .where((movie) => movie.title.toLowerCase().contains(query))
        .toList();

    setState(() {
      _searchResults = results;
    });

    _searchController.text = '';
  }

  void _onButtonPressed() {
    if (_onClick != null) {
      _onClick!.fire();
    }

    setState(() {
      _scale = 0.8;
      _shadowBlur = 40.0; // Blur shadow effect
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _scale = 1.0;
        _shadowBlur = 0.0; // Reset the shadow after the effect
      });
      _searchMovies(); // Execute search when button is pressed
    });
  }

  void _onRiveInit(rive.Artboard artboard) {
    final controller =
        rive.StateMachineController.fromArtboard(artboard, 'State Machine 1');
    if (controller != null) {
      artboard.addController(controller);
      _onClick = controller.findInput('CLICK') as rive.SMITrigger?;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button Press Comparison')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField for movie title
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Movie Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Search button: Built-in or Rive
            widget.useBuiltIn ? _buildBuiltInButton() : _buildRiveButton(),
            const SizedBox(height: 16),
            // List of search results
            Expanded(
              child: _searchResults.isNotEmpty
                  ? ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final movie = _searchResults[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.all(8.0),
                          leading: FadeInImage.assetNetwork(
                            placeholder: 'lib/assets/images/default.png',
                            image: movie.imageUrl,
                            width: 50,
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.broken_image,
                                size: 50,
                              );
                            },
                          ),
                          title: Text(movie.title),
                          subtitle: Text('Release: ${movie.releaseDate}'),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No movies found.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBuiltInButton() {
    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: const Color(0xFF2895FF),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: const Color(0xFF8EC6FF),
            width: 4,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.2),
              blurRadius: _shadowBlur,
              spreadRadius: _shadowBlur,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: _onButtonPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            'Search',
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildRiveButton() {
    return GestureDetector(
      onTap: _onButtonPressed,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: SizedBox(
          width: 240, // Adjust size as needed
          height: 80, // Adjust size as needed
          child: rive.RiveAnimation.asset(
            'lib/assets/rive/button_press.riv',
            onInit: _onRiveInit,
            // fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
