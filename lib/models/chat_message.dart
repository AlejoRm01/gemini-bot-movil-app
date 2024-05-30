class ChatMessage {
  final DateTime time;
  final String message;
  final bool isSender;

  ChatMessage({required this.time, required this.message, required this.isSender});
}