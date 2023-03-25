import 'package:get/get.dart';

import '../controllers/edit_vacation_type_controller.dart';

class EditVacationTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditVacationTypeController>(
      () => EditVacationTypeController(vacation: Get.find()),
    );
    //if we want to save the data use this
  }
}
