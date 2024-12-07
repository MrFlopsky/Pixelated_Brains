import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Hugging Face API Example')),
        body: TextGenerator(),
      ),
    );
  }
}

class TextGenerator extends StatefulWidget {
  @override
  _TextGeneratorState createState() => _TextGeneratorState();
}

class _TextGeneratorState extends State<TextGenerator> {
  TextEditingController _controller = TextEditingController();
  String _generatedText = "";
  String _apiKey = "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"; // Replace with your API key

  Future<void> generateText(String input) async {
    setState(() {
      _generatedText = "Generating text, please wait...";
    });

    final url = Uri.parse(
        'https://api-inference.huggingface.co/models/distilgpt2');

    final headers = {
      'Authorization': 'Bearer $_apiKey',
      'Content-Type': 'application/json'
    };
    
    // Print request details for debugging
    print('Request URL: $url');
    print('Request headers: $headers');
    
    final body = jsonEncode({
      "inputs": input,
      "parameters": {
        "max_length": 50,
        "temperature": 0.7,
        "return_full_text": true,
        "max_time": 20
      }
    });

    try {
      print('Sending request with body: $body');
      final response = await http.post(
        url, 
        headers: headers, 
        body: body
      ).timeout(
        Duration(seconds: 20),
        onTimeout: () {
          print('Request timed out after 20 seconds');
          throw Exception('Request timed out');
        },
      );

      print('Response received');
      print('Status code: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _generatedText = data[0]["generated_text"];
        });
      } else {
        setState(() {
          _generatedText = "Error: Unable to generate text (${response.statusCode})";
        });
        print('Error response body: ${response.body}');
      }
    } catch (e, stackTrace) {
      print('Exception details: $e');
      print('Stack trace: $stackTrace');
      setState(() {
        if (e is Exception) {
          _generatedText = "Error: Request timed out. Please try again.";
        } else {
          _generatedText = "Error: Unable to connect. Please check your internet connection and API key.";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Enter input text'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => generateText(_controller.text),
            child: Text('Generate Text'),
          ),
          SizedBox(height: 16),
          Text(_generatedText),
        ],
      ),
    );
  }
}