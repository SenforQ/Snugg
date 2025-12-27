import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UserAgreementPage extends StatefulWidget {
  const UserAgreementPage({super.key});

  @override
  State<UserAgreementPage> createState() => _UserAgreementPageState();
}

class _UserAgreementPageState extends State<UserAgreementPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
        'https://www.privacypolicies.com/live/69079cf8-9568-4c5c-805e-efaa0506f68c',
      ));
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = AppBar().preferredSize.height;
    final screenHeight = MediaQuery.of(context).size.height;
    final webViewHeight = screenHeight - statusBarHeight - appBarHeight;

    return Scaffold(
      backgroundColor: const Color(0xFF010100),
      appBar: AppBar(
        backgroundColor: const Color(0xFF010100),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'User Agreement',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: statusBarHeight + appBarHeight,
            left: 0,
            right: 0,
            height: webViewHeight,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: WebViewWidget(controller: _controller),
            ),
          ),
        ],
      ),
    );
  }
}

