import 'package:get/get.dart';

import '../controllers/denied_vacations_controller.dart';

class  DeniedVacationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeniedVacationController>(
      () => DeniedVacationController(),
    );
  }
}
