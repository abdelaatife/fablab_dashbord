import 'package:flutter/material.dart';
import 'package:multi_image_layout/multi_image_layout.dart';

class AppPostImageViewer extends StatelessWidget {
  final List imageUrls;

  const AppPostImageViewer(
      {Key? key, required this.imageUrls})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late List<String> images = [];
    for (var i = 0; i < imageUrls.length; i++) {
      images.add(imageUrls[i]);
    }
    return MultiImageViewer(
      images: images,
    );
  }
}
