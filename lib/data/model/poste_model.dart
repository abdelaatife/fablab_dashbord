import 'package:flutter/material.dart';

class PostModel {
  final String id;
  final String personName;
  final String title;
  final String description;
  final List<String> imageUrls;
  final DateTime date;
  final int likes;
  final Color color;

  PostModel(
      {required this.id,
      required this.personName,
      required this.title,
      required this.description,
      required this.imageUrls,
      required this.date,
      required this.color,
      required this.likes});
}
