import 'package:get/get.dart';

import '../controllers/employee_details_controller.dart';

class employeeDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<employeeDetailController>(
      () => employeeDetailController(),
    );
  }
}
