import 'package:flutter/material.dart';
import '../service/chat_service.dart';
import '../widgets/widgets_utils.dart';


class ChatPage extends StatefulWidget {
  static const routeName  = '/chat';
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _chatHistory = [];

  void getAnswer() async {
    final responseMessage = await ChatService.getAnswer(_chatHistory);
    if (responseMessage != null) {
      setState(() {
        _chatHistory.add({
          "time": DateTime.now(),
          "message": responseMessage,
          "isSender": false,
        });
      });

      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 160,
            child: ListView.builder(
              itemCount: _chatHistory.length,
              shrinkWrap: false,
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 10,bottom: 10),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index){
                return ChatBubble(
                  message: _chatHistory[index]["message"],
                  isSender: _chatHistory[index]["isSender"],
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ChatInputField(
              chatController: _chatController,
              onSend: () {
                setState(() {
                  if (_chatController.text.isNotEmpty) {
                    _chatHistory.add({
                      "time": DateTime.now(),
                      "message": _chatController.text,
                      "isSender": true,
                    });
                    _chatController.clear();
                  }
                });

                _scrollController.jumpTo(
                  _scrollController.position.maxScrollExtent,
                );

                getAnswer();
              },
            ),
          )
        ],
      ),
    );
  }
}