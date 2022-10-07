import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fabdashboard/controller/posts/fillepicker_post_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

abstract class AddPostController
    extends GetxController {
  // add post  form controller
  TextEditingController titleController =
      TextEditingController();
  TextEditingController descriptionController =
      TextEditingController();
  TextEditingController usernameController =
      TextEditingController();

  // firebase firestore variables
  FirebaseFirestore firestore =
      FirebaseFirestore.instance;
  // file picker controller variable
  FilepickerControllerImpl filepickerController =
      Get.put(FilepickerControllerImpl());

  // uuid generator
  String? postId = const Uuid().v4();
  // color variables for posts
  List<String> color = [
    "BV",
    "BS",
    "BP",
    "BE",
    "BM"
  ];
  final _random = Random();

// function to add post to firebase firestore
  uploadData();
  validateData();
}

class AddPostControllerImpl
    extends AddPostController {
  // initialize text editing controllers
  @override
  void onInit() {
    titleController = TextEditingController();
    descriptionController =
        TextEditingController();
    usernameController = TextEditingController();
    super.onInit();
  }

// dispose text editing controllers
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  // validate post data
  @override
  validateData() async {
    filepickerController.isUploading = true;
    update();
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        usernameController.text.isEmpty) {
      filepickerController.isUploading = false;
      update();
      Get.snackbar(
          'Error', 'Please fill all fields',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } else if (filepickerController
        .itemImagesList.isEmpty) {
      filepickerController.isUploading = false;
      update();
      Get.snackbar('Error', 'Please select image',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } else {
      uploadData();
    }
  }

// upload post to firebase firestore
  @override
  uploadData() {
    FirebaseFirestore.instance
        .doc('posts/$postId')
        .set({
      "personName": usernameController.text,
      'title': titleController.text,
      'description': descriptionController.text,
      'date': DateTime.now(),
      "likes": 0,
      'color':
          color[_random.nextInt(color.length)],
    }).then((value) {
      // after uploading post data upload images to firebase storage
      filepickerController
          .uplaodImageAndSaveItemInfo(postId!);
    }).catchError((error) {
      Get.snackbar(
          'Error',
          errorPropertyTextConfiguration
              .toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    });
  }
}
