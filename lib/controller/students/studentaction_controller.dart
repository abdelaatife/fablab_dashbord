import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

abstract class StudentActionController
    extends GetxController {
  // firebase firestore and firebase storage variables
  FirebaseFirestore firestore =
      FirebaseFirestore.instance;
  final CollectionReference posts =
      FirebaseFirestore.instance
          .collection('Students');

  movetoapproved(String id);
  movetorejected(String id);
}

class StudentActionControllerImpl
    extends StudentActionController {
  @override
  movetoapproved(String id) async {
    await posts
        .doc(id)
        .update({'status': 'Approved'});
  }

  @override
  movetorejected(String id) {
    posts.doc(id).update({'status': 'Rejected'});
  }
}
