import 'package:get/get.dart';

import '../controllers/Vacation_Home_controller.dart';

class VacationHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VacationHomeController(sharedPreferences: Get.find()));
  }
}
