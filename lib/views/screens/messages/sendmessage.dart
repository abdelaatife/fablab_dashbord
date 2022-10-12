import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/materials/fillepicker_material_controller.dart';
import '../../../core/constant/style.dart';
import '../../widgets/addMaterials/addmaterialform.dart';
import '../../widgets/messages/sendmessage_widget.dart';

class SendMessage extends StatelessWidget {
  const SendMessage({Key? key}) : super(key: key);

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
            'Send Message',
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
                                    "assets/images/newmsg.png",
                                    height:
                                        Get.height *
                                            .7,
                                    width:
                                        Get.width *
                                            .7,
                                  ))),
                                  const AppMessageSend(),
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
                                  const AppMessageSend(),
                                  Expanded(
                                      child: Center(
                                          child: Image.asset(
                                    "assets/images/newmsg.png",
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
