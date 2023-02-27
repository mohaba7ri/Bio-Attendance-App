import 'package:get/get.dart';

import '../controllers/EmployeesRep_controller.dart';


class ListEmployeeRepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListEmployeeRepController>(
      () => ListEmployeeRepController(),
    );
  }
}
