import 'package:get/get.dart';

import '../controllers/list_vacation_requests_controller.dart';

class ListVacationRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListVacationRequestsController>(
      () => ListVacationRequestsController(),
    );
  }
}
