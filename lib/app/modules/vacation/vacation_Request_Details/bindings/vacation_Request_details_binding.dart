import 'package:get/get.dart';

import '../controllers/vacation_Request_details_controller.dart';

class vacationRequestDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<vacationRequestDetailController>(
      () => vacationRequestDetailController(),
    );
  }
}
