import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  static const _apiKey = 'AIzaSyApkxFV2L0bFMPvOY0MSEa--2Sr034yo10';
  static const _url = "https://generativelanguage.googleapis.com/v1beta2/models/chat-bison-001:generateMessage?key=$_apiKey";

  static Future<String?> getAnswer(List<Map<String, dynamic>> chatHistory) async {
    final uri = Uri.parse(_url);
    List<Map<String, String>> msg = [];
    for (var i = 0; i < chatHistory.length; i++) {
      msg.add({"content": chatHistory[i]["message"]});
    }

    Map<String, dynamic> request = {
      "prompt": {"messages": [msg]},
      "temperature": 0.25,
      "candidateCount": 1,
      "topP": 1,
      "topK": 1
    };

    final response = await http.post(uri, body: jsonEncode(request));

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      if (decodedResponse.containsKey("candidates") && decodedResponse["candidates"].length > 0) {
        return decodedResponse["candidates"][0]["content"];
      }
    }

    return null;
  }
}