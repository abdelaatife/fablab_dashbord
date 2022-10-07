import 'dart:io' show File;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

abstract class FilepickerController
    extends GetxController {
  //image picker variable for selecting image from gallery
  final ImagePicker picker = ImagePicker();
  List<XFile>? photo = <XFile>[];
  List<XFile> itemImagesList = <XFile>[];
  List<String> downloadUrl = <String>[];
  bool isSelected = false;
  File? file;
  PickedFile? pickedFile;
  bool uploading = false;
  // bool uploading
  bool isUploading = false;
  //function to select image and add it to firebase storage
  uploadImageToStorage(
      PickedFile? pickedFile, String postId);
  uplaodImageAndSaveItemInfo(String postId);
  pickFile();
}

// pick image
class FilepickerControllerImpl
    extends FilepickerController {
  // pick image function
  @override
  pickFile() async {
    if (kIsWeb) {
      downloadUrl.clear();
      itemImagesList.clear();
      photo = await picker.pickMultiImage();
      if (photo != null) {
        itemImagesList = itemImagesList + photo!;
        isSelected = true;

        photo!.clear();
        update();
      }
    }
  }

// preprossesing picked image
  @override
  uplaodImageAndSaveItemInfo(postId) async {
    uploading = true;
    update();

    for (XFile image in itemImagesList) {
      file = File(image.path);
      pickedFile = PickedFile(file!.path);

      // for each image in the list upload it to firebase storage
      await uploadImageToStorage(
          pickedFile, postId);
    }
    // then add download url to firebase firestore
    FirebaseFirestore.instance
        .doc('posts/$postId')
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
  uploadImageToStorage(pickedFile, postId) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child(
            'posts/$postId/${const Uuid().v4()}');
    await reference.putData(
      await pickedFile!.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    );
    String value =
        await reference.getDownloadURL();
    downloadUrl.add(value);
  }
}
