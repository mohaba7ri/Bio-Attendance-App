import 'package:get/get.dart';

import '../controllers/update_company_controller.dart';

class UpdateCompanyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateCompanyController>(
      () => UpdateCompanyController(),
    );
  }
}
