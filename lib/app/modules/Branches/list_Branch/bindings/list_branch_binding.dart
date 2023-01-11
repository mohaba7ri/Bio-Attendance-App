import 'package:get/get.dart';

import '../controllers/list_branch_controller.dart';

class listBranchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<list_Branches_controller>(
      () => list_Branches_controller(),
    );
  }
}
