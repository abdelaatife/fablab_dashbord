import 'dart:io' show File;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

abstract class FilepickerMaterialController
    extends GetxController {
  //image picker variable for selecting image from gallery
  final ImagePicker picker = ImagePicker();
  XFile? photo;
  XFile? itemImages;
  String? downloadUrl;
  bool isSelected = false;
  File? file;
  PickedFile? pickedFile;
  bool uploading = false;
  // bool uploading
  bool isUploading = false;
  //function to select image and add it to firebase storage
  uploadImageToStorage(
      PickedFile? pickedFile, String materialsId);
  uplaodImageAndSaveItemInfo(String materialsId);
  pickFile();
}

// pick image
class FilepickerMaterialControllerImpl
    extends FilepickerMaterialController {
  // pick image function
  @override
  pickFile() async {
    if (kIsWeb) {
      downloadUrl = null;
      itemImages = null;

      photo = await picker.pickImage(
          source: ImageSource.gallery);
      if (photo != null) {
        itemImages = photo;
        isSelected = true;

        update();
      }
    }
  }

// preprossesing picked image
  @override
  uplaodImageAndSaveItemInfo(materialsId) async {
    uploading = true;
    update();

    file = File(itemImages!.path);
    pickedFile = PickedFile(file!.path);

    // for each image   upload it to firebase storage
    await uploadImageToStorage(
        pickedFile, materialsId);

    // then add download url to firebase firestore
    FirebaseFirestore.instance
        .doc('materials/$materialsId')
        .set(
      {
        'imageUrls': downloadUrl,
      },
      SetOptions(merge: true),
    ).then((value) => {
              Get.back(),
              uploading = false,
              update()
            });
  }

// upload image to firebase storage function
  @override
  uploadImageToStorage(
      pickedFile, materialsId) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child(
            'materials/$materialsId/${const Uuid().v4()}');
    await reference.putData(
      await pickedFile!.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    );
    String value =
        await reference.getDownloadURL();
    downloadUrl = value;
  }
}
