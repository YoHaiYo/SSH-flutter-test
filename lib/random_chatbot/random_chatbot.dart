import 'dart:math';

import 'package:flutter/material.dart';

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  static const List<String> _randomResponses = [    'I am doing well, thank you!',    'That is an interesting question.',    'I am not sure I understand, can you please rephrase that?',    'The weather today is sunny and warm.',    'Have you tried turning it off and on again?',    'I think you should talk to a human about that.',    'My favorite color is blue. What is yours?',    'Do you like cats or dogs?',    'I am sorry, I did not catch that.',    'That is a great idea!',    'I am happy to help.',    'What do you think about the latest news?',  ];

  void _sendMessage(String message) {
    setState(() {
      _messages.add('You: $message');
    });

    final random = Random();
    final response = _randomResponses[random.nextInt(_randomResponses.length)];

    setState(() {
      _messages.add('Bot: $response');
    });
  }


  void _resetChat() {
    setState(() {
      _messages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Bot'),
        actions: [
          ElevatedButton(
            onPressed: _resetChat,
            child: Text(
              'Reset',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter a message',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final message = _controller.text;
                    if (message.isNotEmpty) {
                      _controller.clear();
                      _sendMessage(message);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
