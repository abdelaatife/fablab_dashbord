import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fabdashboard/controller/teachers/teacherspage_controller.dart';
import 'package:fabdashboard/views/widgets/teachers/teachercard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constant/style.dart';

class TeachersPage extends StatelessWidget {
  const TeachersPage({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TeachersPageControllerImpl controller =
        Get.put(TeachersPageControllerImpl());
    return Scaffold(
      // app bar section
      appBar: AppBar(
        title: Row(
          crossAxisAlignment:
              CrossAxisAlignment.center,
          children: [
            const Text(
              "Number of Teachers: ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppText.light),
            ),
            GetBuilder<
                TeachersPageControllerImpl>(
              init: controller,
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
                    stream: controller
                        .collectionStream,
                    builder:
                        (BuildContext context,
                            AsyncSnapshot<
                                    QuerySnapshot>
                                snapshot) {
                      if (!snapshot.hasData) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                          ),
                          itemCount: 20,
                          itemBuilder:
                              (BuildContext
                                      context,
                                  int index) {
                            return Shimmer.fromColors(
                                baseColor: const Color
                                        .fromARGB(
                                    255,
                                    218,
                                    218,
                                    218),
                                highlightColor:
                                    Colors
                                        .black38,
                                child:
                                    const Card());
                          },
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
                                'There is no Teachers submitted yet',
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
                            return AppTeachertCard(
                              id: document.id,
                              supervisorid:
                                  data['id'],
                              name: data[
                                  'fullname'],
                              email:
                                  data['email'],
                              imagurl:
                                  data["fileUrl"],
                              office: data[
                                  "officenumber"],
                              specialization: data[
                                  "sepiclization"],
                              date: data['date'],
                              status:
                                  data['status'],
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
