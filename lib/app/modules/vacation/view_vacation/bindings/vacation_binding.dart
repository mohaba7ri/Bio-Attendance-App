import 'package:get/get.dart';

import '../controllers/vacation_controller.dart';

class VacationTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VacationTypeController>(
      () => VacationTypeController(),
    );
  }
}
