import 'package:get/get.dart';

class ProfileContoller extends GetxController {
  bool profile_show = true;
  void changeState() {
    profile_show = false;
    update();
  }
}
