import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatService {
  final String apiUrl = "https://api.openai.com/v1/chat/completions";

  Future<List<String>> getResponse(String input) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${dotenv.env['OPENAI_KEY']}",
      },
      body: jsonEncode({
        "model": "gpt-4",
        "messages": [
          {
            "role": "user",
            "content":
                " La respuesta tiene que ser muy concisa. objetos tienen que ser string separados por comma. no usar tildes ni accentos. $input. Si no tienes la respuesta con los requisitos escritos entonces responde asi : Solo proporciono una lista o ranking\nPor favor Intentalo de nuevo."
          },
        ]
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String content = data["choices"][0]["message"]["content"];
      List<String> contentInArray = content.split(', ');
      return contentInArray;
    } else {
      Fluttertoast.showToast(
          msg: "Failed to load response...\nsomething went wrong...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      throw Exception('Failed to load response');

    }
  }
}
