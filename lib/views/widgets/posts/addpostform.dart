import 'package:fabdashboard/views/widgets/posts/coustembutton.dart';
import 'package:fabdashboard/views/widgets/posts/imagepicker.dart';
import 'package:fabdashboard/views/widgets/posts/inputform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/style.dart';

class AppAddPostForm extends StatelessWidget {
  const AppAddPostForm({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          children: const [
                            AppInputForm(
                              label: "User Name",
                              icon: Icons.person,
                              helper:
                                  "Enter the name of the project manager",
                            ),
                            AppInputForm(
                              label:
                                  "Project Name",
                              icon: Icons
                                  .factory_outlined,
                              helper:
                                  "Enter project name",
                            ),
                          ],
                        ),

                        /// Image Picker
                        const AppImagePicker(),
                      ],
                    );
                  } else {
                    return Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: const [
                              AppInputForm(
                                label:
                                    "User Name",
                                icon:
                                    Icons.person,
                                helper:
                                    "Enter the name of the project manager",
                              ),
                              AppInputForm(
                                label:
                                    "Project Name",
                                icon: Icons
                                    .factory_outlined,
                                helper:
                                    "Enter project name",
                              ),
                            ],
                          ),
                        ),

                        /// Image Picker
                        const AppImagePicker(),
                      ],
                    );
                  }
                },
              ),
            ),
            const AppInputForm(
              label: "Description",
              icon: Icons.description_outlined,
              maxLines: 5,
              helper: "Enter the Discription",
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end,
              children: [
                AppCusstomButton(
                  label: "Cancel",
                  onTap: () {},
                  color: Colors.white,
                  textColor: Colors.black,
                ),
                AppCusstomButton(
                  label: "Add Post",
                  onTap: () {},
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
