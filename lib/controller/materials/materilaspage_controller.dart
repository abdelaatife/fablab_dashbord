import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

abstract class MaterialsPageController
    extends GetxController {
  // firebase firestore and firebase storage variables
  FirebaseFirestore firestore =
      FirebaseFirestore.instance;
  final CollectionReference posts =
      FirebaseFirestore.instance
          .collection('materials');
  final Reference storageRef =
      FirebaseStorage.instance.ref("materials");

  final Stream<QuerySnapshot> collectionStream =
      FirebaseFirestore.instance
          .collection('materials')
          .snapshots();
  deleteMaterial(String postId);
}

class MaterialsPageControllerImpl
    extends MaterialsPageController {
  //delete post
  @override
  deleteMaterial(String postId) async {
    //delete post from firebase storage
    await storageRef.child(postId).listAll().then(
          // ignore: avoid_function_literals_in_foreach_calls
          (value) => value.items.forEach(
            (element) {
              element.delete();
            },
          ),
        );
    //delete post from firebase firestore
    posts
        .doc(postId)
        .delete()
        .then((value) => Get.back());
  }
}
