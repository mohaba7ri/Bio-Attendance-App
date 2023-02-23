import 'package:get/get.dart';

import '../controller/branch_reports_controller.dart';


class BranchReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BranchReportsController(), permanent: true);
  }
}
