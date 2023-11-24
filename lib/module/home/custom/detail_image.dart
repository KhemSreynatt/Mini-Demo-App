import 'package:flutter/material.dart';

class CustomDetailImage extends StatelessWidget {
  CustomDetailImage({super.key});
  final url = Uri.parse('https://flutter.dev');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Simple Example')),
      // body: WebViewWidget(controller: controller),
    );
  }
}
