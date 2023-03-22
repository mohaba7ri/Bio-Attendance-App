import 'package:get/get.dart';

import '../my_vacation_controller/my_vacation_controller.dart';

class MyVacationBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(MyVacationController(sharedPreferences: Get.find()));
  }
}
