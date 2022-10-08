import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fabdashboard/core/constant/style.dart';
import 'package:fabdashboard/views/widgets/addpost/coustembutton.dart';
import 'package:fabdashboard/views/widgets/students/documentpage.dart';
import 'package:fabdashboard/views/widgets/students/textelement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jiffy/jiffy.dart';

class AppStudentCard extends StatelessWidget {
  final String name,
      year,
      card,
      phone,
      techid,
      url;
  final Timestamp date;
  const AppStudentCard({
    Key? key,
    required this.name,
    required this.year,
    required this.card,
    required this.phone,
    required this.techid,
    required this.url,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 15,
              color: Colors.black12,
              offset: Offset(0, 5),
            )
          ]),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                maxRadius: 25,
                backgroundColor:
                    AppColor.secondry,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontFamily: AppText.light,
                        color: Colors.black),
                  ),
                  Text(
                    Jiffy(date.toDate())
                        .format('dd/MM/yyyy'),
                    style: const TextStyle(
                        fontFamily: AppText.light,
                        color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.start,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                AppStudentPageTextElement(
                    title: 'Year',
                    text: year,
                    icon: Ionicons.school),
                const SizedBox(
                  height: 10,
                ),
                AppStudentPageTextElement(
                    title: 'Card Number',
                    text: card,
                    icon: Ionicons.card),
                const SizedBox(
                  height: 10,
                ),
                AppStudentPageTextElement(
                    title: 'SuperVisor ID',
                    text: techid,
                    icon: Ionicons.person),
                const SizedBox(
                  height: 10,
                ),
                AppStudentPageTextElement(
                    title: 'Phone Number',
                    text: phone,
                    icon: Ionicons.call),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                TextButton(
                    onPressed: () async {
                      Get.to(
                          () => AppDoucumentPage(
                                url: url,
                              ));
                    },
                    child: const Text(
                        'View Project Document')),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                AppCusstomButton(
                    label: 'Reject',
                    onTap: () {},
                    color: Colors.white,
                    borderColor: Colors.red,
                    textColor: Colors.red),
                AppCusstomButton(
                    label: 'Accept',
                    onTap: () {},
                    color: Colors.green,
                    borderColor: Colors.green,
                    textColor: Colors.white)
              ],
            ),
          )
        ],
      ),
    );
  }
}
