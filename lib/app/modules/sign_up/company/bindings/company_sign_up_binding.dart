import 'package:get/get.dart';

import '../controlles/company_sing_up_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanySignUpController>(
      () => CompanySignUpController(),
    );
  }
}
