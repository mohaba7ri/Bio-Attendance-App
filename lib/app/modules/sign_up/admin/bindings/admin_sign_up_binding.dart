import 'package:get/get.dart';
import 'package:presence/app/modules/sign_up/admin/controllers/admin_sing_up_controller.dart';

class AdminSignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminSignUpController>(
      () => AdminSignUpController(),
    );
  }
}
