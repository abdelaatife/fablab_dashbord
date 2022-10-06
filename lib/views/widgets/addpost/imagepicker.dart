import 'package:fabdashboard/controller/fillepicker_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/style.dart';

class AppImagePicker extends StatelessWidget {
  const AppImagePicker({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FilepickerControllerImpl
        filepickerController =
        Get.put(FilepickerControllerImpl());
    return GetBuilder<FilepickerControllerImpl>(
        init: filepickerController,
        builder: ((controller) {
          return controller.isSelected
              ? Padding(
                  padding:
                      const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Text(
                        "${controller.itemImagesList.length} Images",
                        textAlign:
                            TextAlign.center,
                        style: const TextStyle(
                            fontFamily:
                                AppText.light),
                      ),
                      TextButton(
                          onPressed: () {
                            controller.pickFile();
                          },
                          child: const Text(
                            "Change?",
                            style: TextStyle(
                                fontFamily:
                                    AppText
                                        .light),
                          ))
                    ],
                  ),
                )
              : Column(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(
                              top: 50),
                      child: Text('Select Image',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black
                                  .withOpacity(
                                      .5),
                              fontFamily:
                                  AppText.light)),
                    ),
                    InkWell(
                      onTap: () {
                        filepickerController
                            .pickFile();
                      },
                      child: Container(
                        margin:
                            const EdgeInsets.only(
                                left: 30,
                                top: 10,
                                bottom: 0),
                        padding:
                            const EdgeInsets.only(
                                top: 5),
                        width: Get.width * .12,
                        height: Get.width * .085,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius
                                  .circular(10),
                          color: AppColor.secondry
                              .withOpacity(.8),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: Get.width * .075,
                        ),
                      ),
                    ),
                  ],
                );
        }));
  }
}
