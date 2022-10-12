import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fabdashboard/controller/students/studentaction_controller.dart';
import 'package:fabdashboard/core/constant/style.dart';
import 'package:fabdashboard/views/widgets/addpost/coustembutton.dart';
import 'package:fabdashboard/views/widgets/students/documentpage.dart';
import 'package:fabdashboard/views/widgets/students/textelement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

import '../../../controller/teachers/teacheraction_controller.dart';

class AppTeachertCard extends StatelessWidget {
  final String name,
      id,
      supervisorid,
      email,
      imagurl,
      status,
      office,
      specialization;

  final Timestamp date;
  const AppTeachertCard({
    Key? key,
    required this.name,
    required this.date,
    required this.id,
    required this.email,
    required this.imagurl,
    required this.office,
    required this.specialization,
    required this.status,
    required this.supervisorid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TeacherActionControllerImpl
        teacherActionController =
        Get.put(TeacherActionControllerImpl());
    return Container(
      foregroundDecoration:
          RotatedCornerDecoration(
        color: status == 'Approved'
            ? Colors.green
            : status == 'waiting'
                ? AppColor.secondry
                : Colors.red,
        geometry: const BadgeGeometry(
            width: 64, height: 64),
        textSpan: TextSpan(
          text: status,
          style: const TextStyle(
              fontFamily: AppText.light,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ),
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
              CircleAvatar(
                maxRadius: 25,
                backgroundImage:
                    NetworkImage(imagurl),
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
                    title: 'Office Number',
                    text: office,
                    icon: Ionicons.school),
                const SizedBox(
                  height: 10,
                ),
                AppStudentPageTextElement(
                    title: 'Specialization',
                    text: specialization,
                    icon: Ionicons.card),
                const SizedBox(
                  height: 10,
                ),
                AppStudentPageTextElement(
                    title: 'SuperVisor ID',
                    text: supervisorid,
                    icon: Ionicons.person),
                const SizedBox(
                  height: 10,
                ),
                AppStudentPageTextElement(
                    title: 'Email',
                    text: email,
                    icon: Ionicons.mail),
              ],
            ),
          ),
          status == "waiting"
              ? Expanded(
                  child: Row(
                    children: [
                      AppCusstomButton(
                          label: 'Reject',
                          onTap: () {
                            teacherActionController
                                .movetorejected(
                                    id);
                          },
                          color: Colors.white,
                          borderColor: Colors.red,
                          textColor: Colors.red),
                      AppCusstomButton(
                          label: 'Accept',
                          onTap: () {
                            teacherActionController
                                .movetoapproved(
                                    id);
                          },
                          color: Colors.green,
                          borderColor:
                              Colors.green,
                          textColor: Colors.white)
                    ],
                  ),
                )
              : status == "Rejected"
                  ? Expanded(
                      child: Row(
                        children: [
                          AppCusstomButton(
                              label: 'Waiting',
                              onTap: () {
                                teacherActionController
                                    .movetowaiting(
                                        id);
                              },
                              color: Colors.white,
                              textColor: AppColor
                                  .secondry),
                          AppCusstomButton(
                              label: 'Accept',
                              onTap: () {
                                teacherActionController
                                    .movetoapproved(
                                        id);
                              },
                              color: Colors.green,
                              borderColor:
                                  Colors.green,
                              textColor:
                                  Colors.white)
                        ],
                      ),
                    )
                  : Expanded(
                      child: Row(
                        children: [
                          AppCusstomButton(
                              label: 'Reject',
                              onTap: () {
                                teacherActionController
                                    .movetorejected(
                                        id);
                              },
                              color: Colors.white,
                              borderColor:
                                  Colors.red,
                              textColor:
                                  Colors.red),
                          AppCusstomButton(
                              label: 'Waiting',
                              onTap: () {
                                teacherActionController
                                    .movetowaiting(
                                        id);
                              },
                              color: AppColor
                                  .secondry,
                              textColor:
                                  Colors.white)
                        ],
                      ),
                    )
        ],
      ),
    );
  }
}
