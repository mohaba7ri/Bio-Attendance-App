import 'package:get/get.dart';

import '../controller/branch_seting_controlleer.dart';

class BranchSettingBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<BranchSettingController>(
      () => BranchSettingController(),
    );
  }
}
