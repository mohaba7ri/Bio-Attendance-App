import 'package:get/get.dart';

import '../controllers/company_Details_controller.dart';

class CompanyDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyDetailsController>(
      () => CompanyDetailsController(),
    );
  }
}
