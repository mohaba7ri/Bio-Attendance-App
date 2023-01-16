import 'package:get/get.dart';

import '../controllers/Employee_Home_controller.dart';

class EmployeeHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeeHomeController>(
      () => EmployeeHomeController(),
    );
  }
}
