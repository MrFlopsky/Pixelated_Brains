import 'package:flutter/material.dart';

void main() {
  runApp(MusicChatApp());
}

class MusicChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Studio AI',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF2C2C2C), // Dark studio gray
        scaffoldBackgroundColor: Color(0xFF1A1A1A), // Nearly black background
        textTheme: TextTheme(
          displayLarge: TextStyle(  // Folosim displayLarge în loc de headline1
            fontFamily: 'Orbitron',
            color: Colors.greenAccent,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(  // Folosim bodyLarge în loc de bodyText1
            fontFamily: 'Futura',
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String content) {
    if (content.trim().isEmpty) return;

    setState(() {
      messages.add({'sender': 'user', 'text': content, 'time': _getCurrentTime()});
      messages.add({
        'sender': 'bot',
        'text': _generateBotResponse(content),
        'time': _getCurrentTime()
      });
    });

    _controller.clear();
  }

  String _generateBotResponse(String userInput) {
    return "Cool! Let's discuss \"$userInput\".";
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Music Studio AI',
          style: TextStyle(
            fontFamily: 'Orbitron',
            color: Colors.blueGrey.shade500,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Only the feature boxes remain
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            color: Color(0xFF1A1A1A),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blueGrey[900]!, Colors.blueGrey[800]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Choose your preferences',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blueGrey[900]!, Colors.blueGrey[800]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Inspire from your idols',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
