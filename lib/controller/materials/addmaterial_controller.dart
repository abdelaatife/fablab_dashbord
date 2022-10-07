import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fabdashboard/controller/materials/fillepicker_material_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

abstract class AddMaterialController
    extends GetxController {
  // add post  form controller
  TextEditingController materialController =
      TextEditingController();
  TextEditingController
      materialdescriptionController =
      TextEditingController();

  // firebase firestore variables
  FirebaseFirestore firestore =
      FirebaseFirestore.instance;
  // file picker controller variable
  FilepickerMaterialControllerImpl
      filepickerMaterialControllerImpl =
      Get.put(FilepickerMaterialControllerImpl());

  // uuid generator
  String? materialtId = const Uuid().v4();
  // color variables for posts

// function to add post to firebase firestore
  uploadData();
  validateData();
}

class AddMaterialControllerImpl
    extends AddMaterialController {
  // initialize text editing controllers
  @override
  void onInit() {
    materialController = TextEditingController();
    materialdescriptionController =
        TextEditingController();

    super.onInit();
  }

// dispose text editing controllers
  @override
  void dispose() {
    materialController.dispose();
    materialdescriptionController.dispose();

    super.dispose();
  }

  // validate post data
  @override
  validateData() async {
    filepickerMaterialControllerImpl.isUploading =
        true;
    update();
    if (materialController.text.isEmpty ||
        materialdescriptionController
            .text.isEmpty) {
      filepickerMaterialControllerImpl
          .isUploading = false;
      update();
      Get.snackbar(
          'Error', 'Please fill all fields',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } else if (!filepickerMaterialControllerImpl
        .isSelected) {
      filepickerMaterialControllerImpl
          .isUploading = false;
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
        .doc('materials/$materialtId')
        .set({
      'material': materialController.text,
      'materialdescription':
          materialdescriptionController.text,
    }).then((value) {
      // after uploading post data upload images to firebase storage
      filepickerMaterialControllerImpl
          .uplaodImageAndSaveItemInfo(
              materialtId!);
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
