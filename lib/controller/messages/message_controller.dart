import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

abstract class MessageController
    extends GetxController {
  TextEditingController titleController =
      TextEditingController();
  TextEditingController bodyController =
      TextEditingController();
  validateInput();
  sendNotification(
      String token, String title, String body);
}

class MessageControllerImpl
    extends MessageController {
  @override
  void onInit() {
    titleController = TextEditingController();
    bodyController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  validateInput() async {
    if (titleController.text.isEmpty ||
        bodyController.text.isEmpty) {
      Get.snackbar(
          "Error", "Please fill all the fields",
          snackPosition: SnackPosition.TOP);
      return false;
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var user in querySnapshot.docs) {
          sendNotification(
              user["token"],
              titleController.text,
              bodyController.text);
          // ignore: avoid_single_cascade_in_expression_statements
          FirebaseFirestore.instance
            ..collection('users')
                .doc(user.id)
                .collection('notification')
                .add({
              'title': titleController.text,
              'body': bodyController.text,
            }).then((value) {
              titleController.clear();
              bodyController.clear();
            });
        }
      });

      Get.snackbar(
          "Success", "Message sent successfully",
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.green);
    }
  }

  @override
  sendNotification(
      String token, String title, String body) {
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
    } catch (e) {
      print(e);
    }
  }
}
