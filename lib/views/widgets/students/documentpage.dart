import 'package:fabdashboard/core/constant/style.dart';
import 'package:flutter/material.dart';
import 'package:web_browser/web_browser.dart';

class AppDoucumentPage extends StatelessWidget {
  final String url;
  const AppDoucumentPage(
      {Key? key, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Document'),
        backgroundColor: AppColor.secondry,
        elevation: 1,
         
      ),
      body: Center(
          child: WebBrowser(
        initialUrl: url,
        javascriptEnabled: true,
      )),
    );
  }
}
