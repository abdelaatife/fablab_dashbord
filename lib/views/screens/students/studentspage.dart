import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fabdashboard/controller/students/studentspage_controller.dart';
import 'package:fabdashboard/views/widgets/students/studentcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/style.dart';

class StudentsPage extends StatelessWidget {
  const StudentsPage({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentPageControllerImpl
        studentPageControllerImpl =
        Get.put(StudentPageControllerImpl());
    return Scaffold(
      // app bar section
      appBar: AppBar(
        title: Row(
          crossAxisAlignment:
              CrossAxisAlignment.center,
          children: [
            const Text(
              "Number of Students: ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppText.light),
            ),
            GetBuilder<StudentPageControllerImpl>(
              init: studentPageControllerImpl,
              builder: (controller) => Text(
                controller.numberOfStudents
                    .toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppText.light),
              ),
            ),
          ],
        ),
        elevation: .5,
        backgroundColor: AppColor.background,
      ),

      // body section end
      body: LayoutBuilder(
        builder: (BuildContext context,
            BoxConstraints constraints) {
          return Column(
            children: [
              Expanded(
                child: StreamBuilder<
                        QuerySnapshot>(
                    stream:
                        studentPageControllerImpl
                            .collectionStream,
                    builder:
                        (BuildContext context,
                            AsyncSnapshot<
                                    QuerySnapshot>
                                snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child:
                              CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasData) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                                'Something went wrong'),
                          );
                        }
                        if (snapshot
                            .data!.docs.isEmpty) {
                          return Center(
                              child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                            children: const [
                              Icon(
                                Icons
                                    .cloud_off_outlined,
                                color: Colors
                                    .black54,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'There is no Student submitted yet',
                                style: TextStyle(
                                    fontFamily:
                                        AppText
                                            .light,
                                    fontSize: 16,
                                    color: Colors
                                        .black54),
                              ),
                            ],
                          ));
                        }
                      }
                      if (snapshot
                              .connectionState ==
                          ConnectionState
                              .waiting) {
                        return const Center(
                          child:
                              CircularProgressIndicator(),
                        );
                      }

                      return Padding(
                        padding:
                            const EdgeInsets.all(
                                8),
                        child: GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: constraints
                                        .maxWidth >
                                    1900
                                ? 5
                                : constraints
                                            .maxWidth >
                                        1200
                                    ? 4
                                    : constraints
                                                .maxWidth >
                                            900
                                        ? 3
                                        : constraints.maxWidth >
                                                600
                                            ? 2
                                            : 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          padding:
                              EdgeInsets.zero,
                          children: snapshot
                              .data!.docs
                              .map(
                                  (DocumentSnapshot
                                      document) {
                            Map<String, dynamic>
                                data =
                                document.data()
                                    as Map<String,
                                        dynamic>;
                            return AppStudentCard(
                              name: data[
                                  'fullname'],
                              year: data['year'],
                              card: data[
                                  'cardnumber'],
                              phone:
                                  data['phone'],
                              techid: data[
                                  'supervisorId'],
                              url:
                                  data['fileUrl'],
                              date: data['date'],
                            );
                          }).toList(),
                        ),
                      );
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}
