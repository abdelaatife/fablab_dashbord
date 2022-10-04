import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PostsController
    extends GetxController {
  FirebaseFirestore firestore =
      FirebaseFirestore.instance;
  CollectionReference posts = FirebaseFirestore
      .instance
      .collection('posts');
  final Stream<QuerySnapshot> collectionStream =
      FirebaseFirestore.instance
          .collection('posts')
          .snapshots();
  getPostData();
  likeCounter( bool isLiked , String postId);
}

class PostsControllerImpl
    extends PostsController {
  @override
  getPostData() {}

  @override
  likeCounter(isLiked , postId) {
    if (isLiked) {
      posts.doc(postId).update({
        'likes': FieldValue.increment(-1),
      });
      return Future.value(!isLiked);
      
    } else {
      posts.doc('DRiMNaMbVKzMOKOvs8Ho').update({
        'likes': FieldValue.increment(1),
      });
      return Future.value(!isLiked);
      
    }
  }
}
