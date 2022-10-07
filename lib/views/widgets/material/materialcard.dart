import 'package:fabdashboard/controller/materials/materilaspage_controller.dart';
import 'package:fabdashboard/core/constant/style.dart';
import 'package:fabdashboard/views/widgets/posts/imageviewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppMaterialCard extends StatelessWidget {
  final String? title, description, image, id;
  const AppMaterialCard(
      {Key? key,
      required this.title,
      required this.description,
      required this.image,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialsPageControllerImpl
        materialControllerImpl =
        Get.put(MaterialsPageControllerImpl());
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: AppPostImageViewer(
                imageUrls: [image!],
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                   
                    Text(
                      title!,
                      style: const TextStyle(
                          fontFamily:
                              AppText.light,
                          fontWeight:
                              FontWeight.w600,
                          fontSize: 17),
                    ),
                    
                    Text(
                      description!,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontFamily:
                              AppText.light,
                          fontSize: 15),
                    ),
                    // delete button
                  ],
                )),
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.end,
                  children: [
                    Row(
                        mainAxisAlignment:
                            MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext
                                        context) =>
                                    AlertDialog(
                                  title: const Text(
                                      'Delete Material'),
                                  content: const Text(
                                      'Are you sure you want to delete this material?'),
                                  actions: <
                                      Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator
                                              .pop(
                                        context,
                                      ),
                                      child: const Text(
                                          'Cancel'),
                                    ),
                                    TextButton(
                                      onPressed:
                                          () {
                                        materialControllerImpl
                                            .deleteMaterial(
                                                id!);
                                      },
                                      child:
                                          const Text(
                                        'Delete',
                                        style: TextStyle(
                                            color:
                                                Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(
                                  fontFamily:
                                      AppText
                                          .light,
                                  color:
                                      Colors.red,
                                  fontSize: 14),
                            ),
                          ),
                          // edit button
                        ]),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
