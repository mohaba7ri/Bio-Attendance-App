import 'package:get/get.dart';

import '../controllers/reports_home_controller.dart';

class ReportsHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportsHomeController>(
      () => ReportsHomeController(sharedPreferences: Get.find()),
    );
  }
}
