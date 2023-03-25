import 'package:Biometric/app/modules/reports/my_report/controller/my_report_controller.dart';
import 'package:get/get.dart';

class MyReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyReportController(sharedPreferences: Get.find()));
  }
}
