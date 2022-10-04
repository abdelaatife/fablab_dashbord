import 'package:fabdashboard/core/constant/style.dart';
import 'package:flutter/material.dart';

class AppInputForm extends StatelessWidget {
  final TextEditingController? controller;
  final String? label, helper;
  final int? maxLines, minLines;
  final IconData? icon;

  const AppInputForm(
      {Key? key,
      this.controller,
      required this.label,
      this.maxLines,
      this.minLines,
      this.helper,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 5, bottom: 8),
            child: Row(
              children: [
                Text(label!,
                    style: TextStyle(
                        color: Colors.black
                            .withOpacity(.5),
                        fontFamily:
                            AppText.light))
              ],
            ),
          ),
          Form(
            child: TextFormField(
              controller: controller,
              maxLines: maxLines,
              minLines: minLines,
              style: const TextStyle(
                fontFamily: AppText.light,
              ),
              decoration: InputDecoration(
                hintText: helper,
                labelText: label,
                prefixIcon: Icon(icon),
                enabled: true,
                contentPadding:
                    const EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color:
                            AppColor.secondry)),
                disabledBorder:
                    const OutlineInputBorder(
                  borderSide: BorderSide(
                      width: .25,
                      color: AppColor.secondry),
                  borderRadius: BorderRadius.all(
                      Radius.circular(10)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
