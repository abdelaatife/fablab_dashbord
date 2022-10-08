import 'package:flutter/material.dart';

import '../../../core/constant/style.dart';

class AppStudentPageTextElement
    extends StatelessWidget {
  final String title, text;
  final IconData? icon;

  const AppStudentPageTextElement(
      {Key? key,
      required this.title,
      required this.text,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          icon,
          color: Colors.black45,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          '$title: ',
          style: const TextStyle(
              fontFamily: AppText.light,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        Text(
          text,
          style: const TextStyle(
              fontFamily: AppText.light,
              color: Colors.black),
        ),
      ],
    );
  }
}
