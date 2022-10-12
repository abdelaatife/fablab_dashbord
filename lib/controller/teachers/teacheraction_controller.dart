import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

abstract class TeacherActionController
    extends GetxController {
  // firebase firestore and firebase storage variables
  FirebaseFirestore firestore =
      FirebaseFirestore.instance;
  final CollectionReference posts =
      FirebaseFirestore.instance
          .collection('teachers');

  movetoapproved(String id);
  movetorejected(String id);
  movetowaiting(String id);
  seendNotifcation(
      String token, String title, String body);

  late String token;
}

class TeacherActionControllerImpl
    extends TeacherActionController {
  @override
  movetoapproved(String id) async {
    await posts
        .doc(id)
        .update({'status': 'Approved'});
    DocumentSnapshot usertoken =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .get();
    seendNotifcation(
        usertoken["token"],
        'Approved',
        'Congrats your application has been approved !');
  }

  @override
  movetorejected(String id) async {
    posts.doc(id).update({'status': 'Rejected'});
    DocumentSnapshot usertoken =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .get();
    seendNotifcation(
        usertoken["token"],
        'Rejected',
        'Sorry your application has been rejected');
  }

  @override
  movetowaiting(String id) async {
    posts.doc(id).update({'status': 'waiting'});
    DocumentSnapshot usertoken =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .get();
    seendNotifcation(
        usertoken["token"],
        'Waiting',
        'Sorry there is misunderstanding , your application still in review we will contact you soon');
  }

  @override
  seendNotifcation(String token, String title,
      String body) async {
    try {
      http.post(
          Uri.parse(
              'https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            "Content-Type": "application/json",
            "Authorization":
                dotenv.env['messagingapi']!,
          },
          body: jsonEncode(<String, dynamic>{
            "notification": <String, dynamic>{
              "body": body,
              "title": title,
            },
            "priority": "high",
            "data": <String, dynamic>{
              "click_action":
                  "FLUTTER_NOTIFICATION_CLICK",
              "status": "done",
              "body": body,
              "title": title,
            },
            "to": token
          }));
    } catch (e) {}
  }
}
