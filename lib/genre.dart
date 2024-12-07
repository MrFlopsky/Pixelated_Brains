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
    "Latin Music", 
    "Blues",
    "Disco",
    "Reggae",
  ];

  final PageController _pageController = PageController(viewportFraction: 0.12);

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
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.7,
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
                    double scale = 1.0;
                    double opacity = 1.0;
                    double rotateX = 0.0;
                    
                    if (value.abs() <= 1.0) {
                      scale = 1.0 - (value.abs() * 0.3);
                      opacity = 1.0 - (value.abs() * 0.5);
                      rotateX = (value * 0.5);
                    } else {
                      scale = 0.7;
                      opacity = 0.5;
                    }
                    
                    return Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.003)
                        ..translate(0.0, value * 15.0, -value.abs() * 40.0)
                        ..rotateX(rotateX),
                      alignment: Alignment.center,
                      child: Opacity(
                        opacity: opacity,
                        child: Transform.scale(
                          scale: scale,
                          child: child,
                        ),
                      ),
                    );
                  }
                  return child!;
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 3),
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      genres[index],
                      style: TextStyle(
                        fontSize: 14,
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
      ),
    );
  }
}