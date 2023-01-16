import 'package:get/get.dart';

import '../controllers/Employees_controller.dart';

class ListEmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListEmployeeController>(
      () => ListEmployeeController(),
    );
  }
}
