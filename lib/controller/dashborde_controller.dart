import 'package:get/get.dart';

abstract class DashbordeControllerBase
    extends GetxController {
  int selectedIndex = 0;

  nextPage(index);
}

class DashbordeControllerImpl
    extends DashbordeControllerBase {
  @override
  void nextPage(index) {
    selectedIndex = index;
    update();
  }
}
