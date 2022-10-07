import 'package:fabdashboard/views/screens/materials/newmaterial.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/style.dart';

class MaterialsPage extends StatelessWidget {
  const MaterialsPage({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
