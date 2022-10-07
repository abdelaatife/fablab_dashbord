import 'package:fabdashboard/controller/materials/addmaterial_controller.dart';
import 'package:fabdashboard/views/widgets/addMaterials/imagepickermaterial.dart';
import 'package:fabdashboard/views/widgets/addpost/coustembutton.dart';
import 'package:fabdashboard/views/widgets/addpost/inputform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/style.dart';

class AppAddMaterialForm extends StatelessWidget {
  const AppAddMaterialForm({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddMaterialControllerImpl
        addMaterialControllerImpl =
        Get.put(AddMaterialControllerImpl());
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
                                    "Add a New Material",
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
                                  addMaterialControllerImpl
                                      .materialController,
                              maxLength: 20,
                              label:
                                  "Material Name",
                              icon: Icons.person,
                              helper:
                                  "Enter Material Name",
                            ),
                            AppInputForm(
                              controller:
                                  addMaterialControllerImpl
                                      .materialdescriptionController,
                              label:
                                  "Material Description",
                              maxLength: 35,
                              icon: Icons
                                  .factory_outlined,
                              helper:
                                  "Enter Material Description",
                            ),
                          ],
                        ),

                        /// Image Picker
                        const AppImagePickerMaterial(),
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
                                    "Add a New Material",
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
                                  addMaterialControllerImpl
                                      .materialController,
                              maxLength: 20,
                              label:
                                  "Material Name",
                              icon: Icons.person,
                              helper:
                                  "Enter Material Name",
                            ),
                            AppInputForm(
                              controller:
                                  addMaterialControllerImpl
                                      .materialdescriptionController,
                              maxLength: 35,
                              label:
                                  "Material Description",
                              icon: Icons
                                  .factory_outlined,
                              helper:
                                  "Enter Material Description",
                            ),
                          ],
                        )),

                        /// Image Picker
                        const AppImagePickerMaterial(),
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
                  label: "Cancel",
                  onTap: () {
                    Get.back();
                  },
                  color: Colors.white,
                  textColor: Colors.black,
                ),
                AppCusstomButton(
                  label: "Add Material",
                  onTap: () {
                    addMaterialControllerImpl
                        .validateData();
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
