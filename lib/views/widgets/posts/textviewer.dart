import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/style.dart';

class AppPostText extends StatelessWidget {
  final String text;
  const AppPostText(
      {Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ExpandableText(
        text,
        collapseText: 'show less',
        expandText: 'show more',
        maxLines: 2,
        style: const TextStyle(
            fontSize: 14,
            fontFamily: AppText.light,
            height: 1.5),
        linkColor: Colors.blue,
      ),
    );
  }
}
