import 'package:get/get.dart';
import 'package:presence/app/modules/vacation/add_vacation/controllers/add_vacation_controller.dart';

class AddVacationTypeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.Put<AddVacationTypeController>(
    //   () => AddVacationTypeController(),
    // );
    //if we want to save the data use this
    Get.put(AddVacationTypeController(), permanent: true);
  }
}
