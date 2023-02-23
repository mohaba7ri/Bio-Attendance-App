import 'package:get/get.dart';

import '../controllers/list_branchRep_controller.dart';

class listBranchRepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<listBranchRepController>(
      () => listBranchRepController(),
    );
  }
}
