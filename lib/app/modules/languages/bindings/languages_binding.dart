import 'package:get/get.dart';
import 'package:presence/app/modules/languages/controller/languages_controller.dart';

class LanguagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LanguagesController(sharedPreferences: Get.find()));
  }
}
