import 'package:Biometric/app/modules/reports/search_employee/controller/search_controller.dart';
import 'package:get/get.dart';

class SearchEmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(
      () => SearchController(),
    );
  }
}
