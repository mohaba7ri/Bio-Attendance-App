import 'package:get/get.dart';

import '../controllers/EmployeesRep_controller.dart';

class EmployeeReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeeReportController>(
      () => EmployeeReportController(sharedPreferences: Get.find()),
    );
  }
}
