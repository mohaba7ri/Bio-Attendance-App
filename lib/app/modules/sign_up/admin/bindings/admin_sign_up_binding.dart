import 'package:get/get.dart';

import '../controllers/admin_sing_up_controller.dart';

class AdminSignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminSignUpController>(
      () => AdminSignUpController(),
    );
  }
}
