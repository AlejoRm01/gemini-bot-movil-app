import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;

  const ChatBubble({
    required this.message,
    required this.isSender,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: (isSender ? Alignment.topRight : Alignment.topLeft),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            color: (isSender ? const Color(0xFFF69170) : Colors.white),
          ),
          padding: const EdgeInsets.all(16),
          child: Text(
            message,
            style: TextStyle(fontSize: 15, color: isSender ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}

class ChatInputField extends StatelessWidget {
  final TextEditingController chatController;
  final VoidCallback onSend;

  const ChatInputField({
    required this.chatController,
    required this.onSend,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      height: 60,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: GradientBoxBorder(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFF69170),
                      Color(0xFF7D96E6),
                    ],
                  ),
                ),
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Type a message",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  controller: chatController,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4.0),
          MaterialButton(
            onPressed: onSend,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
            padding: const EdgeInsets.all(0.0),
            child: Ink(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFF69170),
                    Color(0xFF7D96E6),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
              child: Container(
                constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
                alignment: Alignment.center,
                child: const Icon(Icons.send, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}