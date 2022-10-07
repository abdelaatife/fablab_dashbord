import 'package:fabdashboard/controller/materials/fillepicker_material_controller.dart';
import 'package:fabdashboard/core/constant/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/addMaterials/addmaterialform.dart';

class NewMaterials extends StatelessWidget {
  const NewMaterials({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FilepickerMaterialControllerImpl
        filepickerMaterialControllerImpl =
        Get.put(
            FilepickerMaterialControllerImpl());
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
              color: Colors.black),
          title: const Text(
            'New Material',
            style: TextStyle(
                fontFamily: AppText.light,
                color: Colors.black),
          ),
          centerTitle: true,
          elevation: .5,
          backgroundColor: AppColor.background,
        ),
        body: SingleChildScrollView(
          child: GetBuilder<
              FilepickerMaterialControllerImpl>(
            init:
                filepickerMaterialControllerImpl,
            builder: (controller) {
              return Padding(
                  padding: EdgeInsets.all(
                      Get.width * .05),
                  child: LayoutBuilder(
                    builder:
                        (context, constraints) {
                      if (constraints.maxWidth <
                          600) {
                        return controller
                                .isUploading
                            ? const Center(
                                child:
                                    CircularProgressIndicator(),
                              )
                            : Wrap(
                                children: [
                                  Expanded(
                                      child: Center(
                                          child: Image.asset(
                                    "assets/images/material.png",
                                    height:
                                        Get.height *
                                            .7,
                                    width:
                                        Get.width *
                                            .7,
                                  ))),
                                  const AppAddMaterialForm(),
                                ],
                              );
                      } else {
                        return controller
                                .isUploading
                            ? const Center(
                                child:
                                    CircularProgressIndicator(),
                              )
                            : Row(
                                children: [
                                  const AppAddMaterialForm(),
                                  Expanded(
                                      child: Center(
                                          child: Image.asset(
                                    "assets/images/material.png",
                                    height:
                                        Get.height *
                                            .7,
                                    width:
                                        Get.width *
                                            .7,
                                  ))),
                                ],
                              );
                      }
                    },
                  ));
            },
          ),
        ));
  }
}
