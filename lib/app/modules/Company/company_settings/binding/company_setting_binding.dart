import 'package:get/get.dart';

import '../controller/company_seting_controlleer.dart';

class CompanySettingBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CompanySettingController>(
      () => CompanySettingController(),
    );
  }
}
