import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Utils/utils.dart';

class NewOpenDocumentScreen extends StatefulWidget {
  const NewOpenDocumentScreen({super.key, required this.getURL});
  final String getURL;
  @override
  State<NewOpenDocumentScreen> createState() => _NewOpenDocumentScreenState();
}

class _NewOpenDocumentScreenState extends State<NewOpenDocumentScreen> {
  var strScreenLoader = '0';
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithRegularStyle(
          'Document',
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
                //
                // Center(child: CircularProgressIndicator());
              },
              onPageFinished: (String url) {
                //
                if (kDebugMode) {
                  print("finished");
                }
                //
                // if (kDebugMode) {
                // print(url);
                // }
                // strScreenLoader = '0';
              },
              onWebResourceError: (WebResourceError error) {
                print('This doc is not supported');
                // s
              },
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
            ),
          ),
      ),
    );
  }
}
