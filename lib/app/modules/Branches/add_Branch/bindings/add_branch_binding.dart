import 'package:get/get.dart';

import '../controllers/add_branch_controller.dart';

class AddBranchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddBranchController>(
      () => AddBranchController(),
    );
  }
}
