import 'package:get/get.dart';

import '../controller/all_branches_reports_controller.dart';

class AllBranchesReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AllBranchesReportsController(), permanent: true);
  }
}
