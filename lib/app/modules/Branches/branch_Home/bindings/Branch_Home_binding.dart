import 'package:get/get.dart';

import '../controllers/Branch_Home_controller.dart';

class BranchHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BranchHomeController>(
      () => BranchHomeController(),
    );
  }
}
