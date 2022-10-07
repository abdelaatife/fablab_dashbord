import 'package:fabdashboard/controller/fillepicker_controller.dart';
import 'package:fabdashboard/core/constant/style.dart';
import 'package:fabdashboard/views/widgets/addpost/addpostform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPostPage extends StatelessWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FilepickerControllerImpl
        filepickerController =
        Get.put(FilepickerControllerImpl());
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
              color: Colors.black),
          title: const Text(
            'New Post',
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
              FilepickerControllerImpl>(
            init: filepickerController,
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
                                    "assets/images/newpost.png",
                                    height:
                                        Get.height *
                                            .7,
                                    width:
                                        Get.width *
                                            .7,
                                  ))),
                                  const AppAddPostForm(),
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
                                  const AppAddPostForm(),
                                  Expanded(
                                      child: Center(
                                          child: Image.asset(
                                    "assets/images/newpost.png",
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
