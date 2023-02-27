import 'package:get/get.dart';

import '../controllers/Company_Home_controller.dart';

class CompanyHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyHomeController>(() => CompanyHomeController(),
        fenix: true);
  }
}
