import 'package:get/get.dart';

import '../controller/daily_report_controller.dart';

class DailyReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DailyReportController(sharedPreferences: Get.find()),
        permanent: true);
  }
}
