import 'package:get/get.dart';
import 'package:presence/app/modules/Branches/add_Branch/controllers/add_branch_controller.dart';

class AddBranchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddBranchController>(
      () => AddBranchController(),
    );
  }
}
