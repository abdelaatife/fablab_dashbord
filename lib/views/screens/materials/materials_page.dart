import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fabdashboard/controller/materials/materilaspage_controller.dart';
import 'package:fabdashboard/views/screens/materials/newmaterial.dart';
import 'package:fabdashboard/views/widgets/material/materialcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constant/style.dart';

class MaterialsPage extends StatelessWidget {
  const MaterialsPage({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialsPageControllerImpl
        materialsPageControllerImpl =
        Get.put(MaterialsPageControllerImpl());
    return Scaffold(
      // app bar section
      appBar: AppBar(
        title: const Text(
          'Materials',
          style: TextStyle(
              fontFamily: AppText.light,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => const NewMaterials(),
                  duration: const Duration(
                      milliseconds: 500),
                  transition:
                      Transition.rightToLeft,
                  curve: Curves.easeOut);
            },
            child: Row(
              children: [
                const Icon(
                  Icons.add,
                  color: AppColor.secondry,
                  size: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: const [
                    Text(
                      'New Material',
                      style: TextStyle(
                          fontFamily:
                              AppText.light,
                          fontSize: 17,
                          fontWeight:
                              FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: Get.width * .05,
          ),
          const CircleAvatar(
            backgroundColor: AppColor.secondry,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
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
                        materialsPageControllerImpl
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
                                'There is no materials yet, you can add new material',
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

                      return GridView(
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: constraints
                                      .maxWidth >
                                  1300
                              ? 6
                              : constraints
                                          .maxWidth >
                                      820
                                  ? 4
                                  : constraints
                                              .maxWidth >
                                          620
                                      ? 3
                                      : constraints.maxWidth >
                                              450
                                          ? 2
                                          : 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        padding: EdgeInsets.zero,
                        children: snapshot
                            .data!.docs
                            .map((DocumentSnapshot
                                document) {
                          Map<String, dynamic>
                              data =
                              document.data()
                                  as Map<String,
                                      dynamic>;
                          return AppMaterialCard(
                            image:
                                data['imageUrls'],
                            title:
                                data['material'],
                            description: data[
                                'materialdescription'],
                            id: document.id,
                          );
                        }).toList(),
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
