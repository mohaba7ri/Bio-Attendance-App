import 'package:get/get.dart';

import '../controllers/on_vacation_requests_controller.dart';

class  OnVacationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnVacationController>(
      () => OnVacationController(),
    );
  }
}
