import 'dart:convert'; // For JSON encoding/decoding
import 'package:http/http.dart' as http; // For making HTTP requests
import 'package:flutter/material.dart'; // For UI
import 'package:audioplayers/audioplayers.dart'; // For playing audio

void main() {
  runApp(MaterialApp(
    home: MusicGeneratorScreen(),
  ));
}

Future<String> generateMusic(String prompt) async {
  final url = Uri.parse("https://huggingface.co/spaces/facebook/MelodyFlow/api");
  final headers = {
    'Authorization': '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', // Replace with your API key
    'Content-Type': 'application/json',
  };
  final body = jsonEncode({
    "prompt": prompt,
    "parameters": {"bpm": 120}
  });

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data["audio_url"]; // Assuming the API returns an "audio_url"
  } else {
    throw Exception('Error: ${response.statusCode} ${response.body}');
  }
}

Future<void> playAudio(String audioUrl) async {
  final player = AudioPlayer();
  await player.play(audioUrl);
}

class MusicGeneratorScreen extends StatefulWidget {
  @override
  _MusicGeneratorScreenState createState() => _MusicGeneratorScreenState();
}

class _MusicGeneratorScreenState extends State<MusicGeneratorScreen> {
  TextEditingController _promptController = TextEditingController();
  String _status = "Enter a music prompt.";
  String _audioUrl = "";

  Future<void> generateAndPlayMusic() async {
    setState(() {
      _status = "Generating music...";
    });

    try {
      final url = await generateMusic(_promptController.text);
      setState(() {
        _status = "Music generated! Playing now...";
        _audioUrl = url;
      });
      await playAudio(url);
    } catch (e) {
      setState(() {
        _status = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MelodyFlow Music Generator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _promptController,
              decoration: InputDecoration(labelText: 'Enter a music prompt'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: generateAndPlayMusic,
              child: Text('Generate Music'),
            ),
            SizedBox(height: 16),
            Text(_status),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }
}