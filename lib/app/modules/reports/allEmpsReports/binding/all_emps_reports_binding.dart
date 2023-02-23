import 'package:get/get.dart';

import '../controller/all_emps_reports_controller.dart';

class AllEmpsReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AllEmpsReportsController(), permanent: true);
  }
}
