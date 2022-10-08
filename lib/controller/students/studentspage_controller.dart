import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

abstract class StudentPageController
    extends GetxController {
  // firebase firestore and firebase storage variables
  FirebaseFirestore firestore =
      FirebaseFirestore.instance;
  final CollectionReference posts =
      FirebaseFirestore.instance
          .collection('Students');
  final Reference storageRef =
      FirebaseStorage.instance.ref("Students");
  late int? numberOfStudents = 0;

  final Stream<QuerySnapshot> collectionStream =
      FirebaseFirestore.instance
          .collection('Students')
          .orderBy("status", descending: true)
          .snapshots();
  deletePost(String postId);
}

class StudentPageControllerImpl
    extends StudentPageController {
  // get number of posts in the collection
  @override
  void onInit() {
    posts.get().then((value) {
      numberOfStudents = value.docs.length;
      print(numberOfStudents);
      update();
    });
    super.onInit();
  }

  //delete post
  @override
  deletePost(String postId) async {
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
