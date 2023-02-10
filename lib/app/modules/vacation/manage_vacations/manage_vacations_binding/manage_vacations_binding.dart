import 'package:get/get.dart';

import '../manage_vacations_controller/manage_vacations_controller.dart';

class ManageVacationBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ManageVacationController(), permanent: true);
  }
}
