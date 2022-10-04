import 'package:fabdashboard/views/widgets/posts/addpostform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPostPage extends StatelessWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
          padding:
              EdgeInsets.all(Get.width * .05),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return Wrap(
                  children: [
                    Expanded(
                        child: Center(
                            child: Image.asset(
                      "assets/images/newpost.png",
                      height: Get.height * .7,
                      width: Get.width * .7,
                    ))),
                    const AppAddPostForm(),
                  ],
                );
              } else {
                return Row(
                  children: [
                    const AppAddPostForm(),
                    Expanded(
                        child: Center(
                            child: Image.asset(
                      "assets/images/newpost.png",
                      height: Get.height * .7,
                      width: Get.width * .7,
                    ))),
                  ],
                );
              }
            },
          )),
    ));
  }
}
