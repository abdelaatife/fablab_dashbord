import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class PostsController
    extends GetxController {
  // firebase firestore and firebase storage variables
  FirebaseFirestore firestore =
      FirebaseFirestore.instance;
  final CollectionReference posts =
      FirebaseFirestore.instance
          .collection('posts');
  final Reference storageRef =
      FirebaseStorage.instance.ref("posts");

  final Stream<QuerySnapshot> collectionStream =
      FirebaseFirestore.instance
          .collection('posts')
          .snapshots();
  deletePost(String postId);
}

class PostsControllerImpl
    extends PostsController {
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
