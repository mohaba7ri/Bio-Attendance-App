import 'package:get/get.dart';
import 'package:presence/app/controllers/biometric_controller.dart';
import 'package:presence/app/controllers/presence_controller.dart';
import 'package:presence/app/routes/app_pages.dart';

class PageIndexController extends GetxController {
  final presenceController = Get.find<PresenceController>();
  var biometricController = Get.find<BiometricController>();

  RxInt pageIndex = 0.obs;

  void changePage(int index) async {
    pageIndex.value = index;
    switch (index) {
      case 1:
        if (biometricController.isEnabled == true) {
          biometricController.fingerprintLogin();
          presenceController
            ..checkTime()
            ..presence();
        } else {
          presenceController
            ..checkTime()
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
