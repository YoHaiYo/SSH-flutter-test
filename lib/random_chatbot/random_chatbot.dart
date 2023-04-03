import 'dart:math';

import 'package:flutter/material.dart';

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  static const List<String> _randomResponses = [
  "안녕하세요. 오늘 무엇을 도와드릴까요?",
  "무슨 일로 여기 오셨습니까?",
  "도와드리겠습니다. 어떻게 도움이 될까요?",
    "다시 찾고 있습니다.",
    "저는 당신을 돕기 위해 프로그래밍된 챗봇입니다. 오늘 무엇을 도와드릴까요?",
    "부끄러워하지 말고 무엇이든 물어보세요.","죄송합니다. 잘 알아듣지 못했습니다. 질문을 바꿔 주시겠어요?", "어떤 정보를 찾을 수 있는지 알려주세요.", "필요하시면 언제든지 채팅할 수 있습니다.",
    " 질문이 있으시면 기꺼이 답변해 드리겠습니다. 도움이 필요한 사항만 알려주세요."
  ];

  void _sendMessage(String message) {
    setState(() {
      _messages.add('나: $message');
    });
    final random = Random();
    final response = _randomResponses[random.nextInt(_randomResponses.length)];
    setState(() {
      _messages.add('상대: $response');
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
        title: Text('챗봇 테스트'),
        actions: [
          ElevatedButton(
            onPressed: _resetChat,
            child: Text(
              '대화리셋',
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
            child: Container(
              decoration: BoxDecoration(

                image: DecorationImage(
                fit:BoxFit.cover,
                image:NetworkImage('https://wallpapers.com/images/featured/mvehfqz6w2ges2dj.jpg'),opacity: 0.3
                ),

                // gradient: const LinearGradient(
                //   // begin: Alignment.topLeft,
                //   // end: Alignment.bottomRight,
                //
                //   /// 1.57 -> 시계방향으로 90도
                //   /// 3.14 -> 시계방향으로 180도 회전
                //   /// 6.28 -> 시계방향으로 360도 회전
                //   /// -1.57 -> 반 시계방향으로 90도
                //   /// -3.14 -> 반 시계방향으로 180도 회전
                //   /// -6.28 -> 반 시계방향으로 360도 회전
                //   transform: GradientRotation(1.57),
                //   colors: [
                //     Colors.cyanAccent,
                //     Colors.white,
                //     Colors.white,
                //   ],
                // ),
              ),

              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_messages[index]),
                ),
              ),
            ),
          ),
          /// 메시지 입력창 부분
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.cyan.shade100,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: '메시지를 입력하세요.',
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
