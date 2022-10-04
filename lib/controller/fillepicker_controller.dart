import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

abstract class FilepickerController
    extends GetxController {
  late String fileName;
  late File file;
  late bool isFilePicked = false;
  late List<PlatformFile> files = [];
  late bool isSelected = false;

  pickFile();
}

class FilepickerControllerImpl
    extends FilepickerController {
  @override
  pickFile() async {
    files.clear();
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      withReadStream: true,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      for (var element in result.files) {
        files.add(element);
      }
      isSelected = true;
      update();
    }
  }
}