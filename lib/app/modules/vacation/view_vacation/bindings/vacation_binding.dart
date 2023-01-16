import 'package:get/get.dart';

import '../controllers/vacation_controller.dart';

class ListVacationTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListVacationTypeController>(
      () => ListVacationTypeController(),
    );
  }
}
