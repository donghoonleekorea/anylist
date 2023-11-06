import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../services/chat_services.dart';


class HomeViewModel extends ChangeNotifier {
  final ChatService _chatService = ChatService();
  List<String> response = [];
  TextEditingController textEditingController = TextEditingController();
  String text = '';
  bool isLoadingResponse = false;
  VideoPlayerController? _controller;

  VideoPlayerController? get controller => _controller;

  // HomeViewModel() {
  //   initializeVideo('assets/videos/home_video.mp4');
  // }

  void initializeVideo(String videoAssetPath) {
    _controller ??= VideoPlayerController.asset(videoAssetPath)
        ..initialize().then((_) {
          notifyListeners();
        })
        ..setLooping(true)
        ..play();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void getChatResponse(String input) async {
    response = await _chatService.getResponse(input);
    text = '';
    notifyListeners();
  }
}