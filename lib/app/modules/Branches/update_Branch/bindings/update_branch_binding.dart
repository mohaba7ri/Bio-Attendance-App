import 'package:get/get.dart';
import 'package:presence/app/modules/Branches/add_Branch/controllers/add_branch_controller.dart';

import '../controllers/update_branch_controller.dart';

class UpdateBranchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateBranchController>(
      () => UpdateBranchController(),
    );
  }
}
