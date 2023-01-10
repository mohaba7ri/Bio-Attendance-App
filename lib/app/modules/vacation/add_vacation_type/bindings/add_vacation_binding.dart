import 'package:get/get.dart';

import '../controllers/add_vacation_type_controller.dart';

class AddVacationTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddVacationTypeController>(
      () => AddVacationTypeController(),
    );
    //if we want to save the data use this
  }
}
