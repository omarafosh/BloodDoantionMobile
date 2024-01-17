import 'package:get/get.dart';

class ProfileContoller extends GetxController {
  bool profile_show = true;
  bool isActive = true;
  void changeState() {
    profile_show = false;
    update();
  }

  void changeActive() {
    isActive = true;
    update();
  }
}
