import 'package:get/get.dart';

import '../controllers/request_vacation_controller.dart';

class RequestVacationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VacationRequestController>(
      () => VacationRequestController(sharedPreferences: Get.find()),
    );
    //if we want to save the data use this
    // Get.put(VacationRequestController(), permanent: true);
  }
}
