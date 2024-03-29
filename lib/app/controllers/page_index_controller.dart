import 'package:Biometric/app/controllers/presence_controller.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';
import 'biometric_controller.dart';

class PageIndexController extends GetxController {
  final presenceController = Get.find<PresenceController>();
  var biometricController = Get.find<BiometricController>();

  RxInt pageIndex = 0.obs;

  void changePage(int index) async {
    pageIndex.value = index;
    switch (index) {
      case 1:
        if (biometricController.isEnabled == true) {
          biometricController.bioMetricPresence();
          presenceController
            ..checkTime()
            ..getVacationRequest()
            ..presence();
        } else {
          presenceController
            ..checkTime()
            ..getVacationRequest()
            ..presence();
        }

        break;
      case 2:
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
        break;
    }
  }
}
