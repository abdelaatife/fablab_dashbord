import 'package:fabdashboard/controller/materials/addmaterial_controller.dart';
import 'package:fabdashboard/controller/messages/message_controller.dart';
import 'package:fabdashboard/views/widgets/addMaterials/imagepickermaterial.dart';
import 'package:fabdashboard/views/widgets/addpost/coustembutton.dart';
import 'package:fabdashboard/views/widgets/addpost/inputform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/style.dart';

class AppMessageSend extends StatelessWidget {
  const AppMessageSend({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MessageControllerImpl messageControllerImpl =
        Get.put(MessageControllerImpl());
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: LayoutBuilder(
                builder: (BuildContext context,
                    BoxConstraints constraints) {
                  if (constraints.maxWidth <
                      300) {
                    return Wrap(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons
                                      .add_circle_outline,
                                  color: AppColor
                                      .secondry,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    "Send a new message",
                                    style: TextStyle(
                                        fontFamily:
                                            AppText
                                                .light,
                                        fontSize:
                                            20,
                                        fontWeight:
                                            FontWeight
                                                .w600)),
                              ],
                            ),
                            SizedBox(
                              height: Get.height *
                                  .08,
                            ),
                            AppInputForm(
                              controller:
                                  messageControllerImpl
                                      .titleController,
                              maxLength: 15,
                              label: "Title",
                              icon: Icons.person,
                              helper:
                                  "Notifcation title",
                            ),
                            AppInputForm(
                              controller:
                                  messageControllerImpl
                                      .bodyController,
                              label: "Body",
                              maxLength: 30,
                              icon: Icons
                                  .factory_outlined,
                              helper:
                                  "Notification body",
                            ),
                          ],
                        ),

                        /// Image Picker
                      ],
                    );
                  } else {
                    return Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons
                                      .add_circle_outline,
                                  color: AppColor
                                      .secondry,
                                  size: 30,
                                ),
                                Text(
                                    "Send a new message",
                                    style: TextStyle(
                                        fontFamily:
                                            AppText
                                                .light,
                                        fontSize:
                                            20,
                                        fontWeight:
                                            FontWeight
                                                .w600)),
                              ],
                            ),
                            SizedBox(
                              height: Get.height *
                                  .08,
                            ),
                            AppInputForm(
                              controller:
                                  messageControllerImpl
                                      .titleController,
                              maxLength: 15,
                              label: "Title",
                              icon: Icons.person,
                              helper:
                                  "Notifcation title",
                            ),
                            AppInputForm(
                              controller:
                                  messageControllerImpl
                                      .bodyController,
                              maxLength: 30,
                              label: "Body",
                              icon: Icons
                                  .factory_outlined,
                              helper:
                                  "Notification body",
                            ),
                          ],
                        )),

                        /// Image Picker
                      ],
                    );
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end,
              children: [
                AppCusstomButton(
                  label: "Send",
                  onTap: () {
                    messageControllerImpl
                        .validateInput();
                  },
                  color: AppColor.secondry,
                  textColor: Colors.white,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
