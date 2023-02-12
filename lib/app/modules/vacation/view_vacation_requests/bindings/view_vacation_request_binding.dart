import 'package:get/get.dart';

import '../controllers/view_vacation_request_controller.dart';

class ViewVacationRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewVacationRequestsController>(
      () => ViewVacationRequestsController(),
    );
  }
}
