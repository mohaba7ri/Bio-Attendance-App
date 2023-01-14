import 'package:get/get.dart';

import '../controllers/branch_details_controller.dart';

class detailBranchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<detailBranchController>(
      () => detailBranchController(),
    );
  }
}
