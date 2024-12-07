import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VerticalCarousel(),
    );
  }
}

class VerticalCarousel extends StatefulWidget {
  @override
  _VerticalCarouselState createState() => _VerticalCarouselState();
}

class _VerticalCarouselState extends State<VerticalCarousel> {
  final List<String> genres = [
    "Pop",
    "Hip-Hop and Rap",
    "Jazz",
    "Electric",
    "Classical Music",
    "Latino Music",
    "Blues",
    "Disco",
    "Reggae",
  ];

  final PageController _pageController = PageController(viewportFraction: 0.25);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 61, 0, 116),
      appBar: AppBar(
        title: Text("Choose a Genre"),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Center(
        child: PageView.builder(
          scrollDirection: Axis.vertical,
          controller: _pageController,
          itemCount: genres.length,
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                double value = 1.0;
                if (_pageController.position.haveDimensions) {
                  value = _pageController.page! - index;
                  // Modified scale calculation for wheel effect
                  double scale = 1.0;
                  if (value < 0) {
                    // Items above current
                    scale = 0.8 - (value.abs() * 0.1);
                  } else if (value > 0) {
                    // Items below current
                    scale = 0.8 - (value * 0.1);
                  } else {
                    // Current item
                    scale = 1.0;
                  }
                  scale = scale.clamp(0.6, 1.0);

                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.002) // Perspective
                      ..translate(0.0, value * 30.0, 0.0)
                      ..scale(scale),
                    alignment: Alignment.center,
                    child: child,
                  );
                }
                return child!;
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    genres[index],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}