import 'package:get/get.dart';

import '../controller/emp_reports_controller.dart';

class EmpReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmpReportsController());
  }
}
