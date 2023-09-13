import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:water_ship/classes/Utils/utils.dart';

import 'package:webview_flutter/webview_flutter.dart';

class PlayVideoScreen extends StatefulWidget {
  const PlayVideoScreen({super.key, required this.getURL});
  final String getURL;
  @override
  State<PlayVideoScreen> createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  //
  // late final PodPlayerController controller;
  //
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print('========================');
      print('========================');
      print(widget.getURL);
      print('========================');
      print('========================');
    }
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithRegularStyle(
          'Video',
          Colors.white,
          14.0,
        ),
        backgroundColor: navigationColor,
      ),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          // ..setBackgroundColor(const Color(0x00000000))
          ..setBackgroundColor(
            const Color.fromARGB(
              0,
              226,
              28,
              28,
            ),
          )
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                // Update loading bar.
                // print(progress);
              },
              onPageStarted: (String url) {
                //
                if (kDebugMode) {
                  print("started");
                }
              },
              onPageFinished: (String url) {
                //
                if (kDebugMode) {
                  print("finished");
                }
              },
              onWebResourceError: (WebResourceError error) {},
              onNavigationRequest: (NavigationRequest request) {
                if (request.url.startsWith('https://www.youtube.com/')) {
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(
            Uri.parse(
              widget.getURL.toString(),
              // 'https://firebasestorage.googleapis.com/v0/b/my-ship-3939d.appspot.com/o/chatDoc%2FoWqHEOXSLUYXldoSZNsmoUMnFTl2%2FaA2hBZxbvl?alt=media&token=c7b29566-724a-4671-b91b-14a178eb7bb9',
            ),
          ),
      ),
    );
  }
}
