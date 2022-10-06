import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../../../core/constant/style.dart';

class AppHeaderPost extends StatelessWidget {
  final String name, title;
  final Timestamp time;
  const AppHeaderPost(
      {Key? key,
      required this.name,
      required this.title,
      required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: const TextStyle(
              fontFamily: AppText.light,
              fontSize: 17,
              fontWeight: FontWeight.bold),
        ),
        Flexible(
          child: Text(
            title,
            style: const TextStyle(
                fontFamily: AppText.light,
                fontSize: 15),
          ),
        ),
        Text(
          Jiffy(time.toDate())
              .format('dd/MM/yyyy'),
          style: const TextStyle(
              fontFamily: AppText.light,
              fontSize: 15),
        ),
      ],
    );
  }
}
