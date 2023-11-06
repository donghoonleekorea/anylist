import 'package:anylist/viewmodels/home_viewmodel.dart';
import 'package:anylist/views/response_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final videoController = Provider.of<HomeViewModel>(context);

    videoController.initializeVideo('assets/videos/home_video.mp4');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<HomeViewModel>(
        builder: (context, model, child) {
          if (model.controller == null || !model.controller!.value.isInitialized) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Stack(
              children: <Widget>[
                Positioned.fill(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: model.controller?.value.size?.width ?? 0,
                      height: model.controller?.value.size?.height ?? 0,
                      child: VideoPlayer(model.controller!),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Center(
                      child: Column(
                        children: [
                          Container(
                            color: Colors.transparent,
                            child: Image.asset(
                              'assets/images/logo.png',
                              fit: BoxFit.cover,
                              width: 200,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 300,
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              //Normal textInputField will be displayed
                              maxLines: 3,
                              // when user presses enter it will adapt to it
                              decoration: const InputDecoration(
                                hintText: '10 mejores restaurantes de Barcelona',
                                hintStyle: TextStyle(color: Colors.white54),
                              ),
                              autofocus: false,
                              controller: model.textEditingController,
                              style: const TextStyle(color: Colors.white),
                              onChanged: (text) {
                                model.text = text;
                              },
                              onSubmitted: (value) {
                                model.getChatResponse(value);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ResponseView(),
                                  ),
                                );
                                model.textEditingController.clear();
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white, foregroundColor: Colors.deepPurpleAccent //<-- SEE HERE
                                ),
                            onPressed: () {
                              model.getChatResponse(model.text);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ResponseView(),
                                ),
                              );
                              model.textEditingController.clear();
                            },
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          // else {
          // // If the video is not initialized, show a CircularProgressIndicator
          // return const Center(child: CircularProgressIndicator());
          // }
        },
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: Colors.white,
//     appBar: AppBar(
//       backgroundColor: Colors.white,
//       centerTitle: true,
//       title: Image.asset(
//         'assets/images/tutor.png',
//         fit: BoxFit.cover,
//         width: 150,
//       ),
//       toolbarHeight: 150,
//     ),
//     body: Consumer<HomeViewModel>(
//       builder: (context, model, child) => Center(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 200,
//             ),
//             Container(
//               width: 300,
//               child: TextField(
//                 autofocus: false,
//                 controller: model.textEditingController,
//                 onChanged: (text) {
//                   model.text = text;
//                 },
//                 onSubmitted: (value) {
//                   model.getChatResponse(value);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ResponseView(),
//                     ),
//                   );
//                   model.textEditingController.clear();
//                 },
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 model.getChatResponse(model.text);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ResponseView(),
//                   ),
//                 );
//                 model.textEditingController.clear();
//               },
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
}
