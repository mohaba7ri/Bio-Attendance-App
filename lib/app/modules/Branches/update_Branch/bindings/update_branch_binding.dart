import 'package:get/get.dart';

import '../controllers/update_branch_controller.dart';

class UpdateBranchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateBranchController>(
      () => UpdateBranchController(),
    );
  }
}
