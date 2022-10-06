import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/style.dart';

class AppCusstomButton extends StatelessWidget {
  final String label;
  final void Function() onTap;
  final Color color, textColor;

  const AppCusstomButton(
      {Key? key,
      required this.label,
      required this.onTap,
      required this.color,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onTap,
        child: Container(
          height: Get.height * .055,
          width: Get.width * .08,
          decoration: BoxDecoration(
              border: Border.all(
                  color: AppColor.secondry),
              borderRadius:
                  BorderRadius.circular(10),
              color: color),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                  color: textColor,
                  fontFamily: AppText.light),
            ),
          ),
        ));
  }
}
