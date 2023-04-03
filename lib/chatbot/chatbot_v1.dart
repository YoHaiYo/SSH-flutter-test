import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


const String openaiApiKey = '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';

class ChatBotGPT extends StatefulWidget {
  @override
  _ChatBotGPTState createState() => _ChatBotGPTState();
}

class _ChatBotGPTState extends State<ChatBotGPT> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  Future<void> _sendMessage(String message) async {
    setState(() {
      _messages.add('You: $message');
    });

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/engines/davinci-codex/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $openaiApiKey',
      },
      body: jsonEncode({
        'prompt': 'User: $message\nBot:',
        'temperature': 0.7,
        'max_tokens': 50,
        'n': 1,
        'stop': ['\n'],
      }),
    );

    final data = jsonDecode(response.body)['choices'][0]['text'].toString().trim();

    setState(() {
      _messages.add('Bot: $data');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Bot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_messages[index]),
              ),
            ),
          ),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter a message',
            ),
            onSubmitted: (message) {
              _controller.clear();
              _sendMessage(message);
            },
          ),
        ],
      ),
    );
  }
}