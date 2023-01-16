import 'package:get/get.dart';

import '../controllers/Vacation_Home_controller.dart';

class VacationHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VacationHomeController>(
      () => VacationHomeController(),
    );
  }
}
