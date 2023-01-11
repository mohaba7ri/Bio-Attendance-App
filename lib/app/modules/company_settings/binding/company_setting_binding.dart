import 'package:get/get.dart';
import 'package:presence/app/modules/company_settings/controller/company_seting_controlleer.dart';

class CompanySettingBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CompanySettingController>(
      () => CompanySettingController(),
    );
  }
}
