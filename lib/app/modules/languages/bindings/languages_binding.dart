import 'package:get/get.dart';

import '../controller/languages_controller.dart';

class LanguagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LanguagesController(
        sharedPreferences: Get.find(), apiClient: Get.find()));
  }
}
