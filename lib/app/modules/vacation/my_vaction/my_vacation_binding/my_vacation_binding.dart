import 'package:get/get.dart';
import 'package:presence/app/modules/vacation/my_vaction/my_vacation_controller/my_vacation_controller.dart';

class MyVacationBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(MyVacationController(), permanent: true);
  }
}
