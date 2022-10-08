import 'package:flutter/material.dart';
import 'package:web_browser/web_browser.dart';

class Test extends StatelessWidget {
  const Test({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: WebBrowser(
        initialUrl:
            'https://firebasestorage.googleapis.com/v0/b/fablab-b6fb5.appspot.com/o/Students%2FTP0E0OVb5ap5VUAb9p77%2FIntroduction.pdf?alt=media&token=20bf5635-f551-4a5e-bac4-4a924fc13493',
      )),
    );
  }
}
