import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
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
  movetowaiting(String id);
  seendNotifcation(
      String token, String title, String body);

  late String token;
}

class StudentActionControllerImpl
    extends StudentActionController {
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
        'Congrats your project has been approved !');
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
        'Sorry your project has been rejected');
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
        'Sorry there is misunderstanding , your project still in review we will contact you soon');
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
                'Key=AAAA3R61kOg:APA91bGv0YZhHUUa7fo_OK3LcMxt3nlTJb9gt-GcBJc-d7Np86otRJ6rXVNR9l9Jpld9gca76HXddm050BLoqc8EVqJsDNtBI0ANIRAcRG1kO7eruM5HUbc0V2wOowcMEgRP_XuK_EOT'
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
