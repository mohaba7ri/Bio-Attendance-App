import 'package:get/get.dart';

import '../controllers/employee_details_controller.dart';

class EmployeeDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeeDetailController>(
      () => EmployeeDetailController(),
    );
  }
}
