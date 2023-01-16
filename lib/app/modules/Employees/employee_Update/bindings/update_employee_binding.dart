import 'package:get/get.dart';

import '../controllers/update_employee_controller.dart';

class UpdateEmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateEmployeeController>(
      () => UpdateEmployeeController(),
    );
  }
}
