import 'package:flutter/material.dart';

// card model

class CardModel {
  final String titel, description, image;
  final Color color;
  final void Function() onTap;
  const CardModel({
   required this.onTap,
    required this.titel,
    required this.description,
    required this.image,
    required this.color,
  });
}
