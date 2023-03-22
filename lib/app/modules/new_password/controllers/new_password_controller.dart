import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


import '../../../../company_data.dart';
import '../../../controllers/page_index_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/toast/custom_toast.dart';

class NewPasswordController extends GetxController {
  final pageIndexController = Get.find<PageIndexController>();
  RxBool isLoading = false.obs;
  TextEditingController passC = TextEditingController();
  TextEditingController confirmPassC = TextEditingController();

  RxBool newPassObs = true.obs;
  RxBool newPassCObs = true.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  void newPassword() async {
    if (passC.text.isNotEmpty && confirmPassC.text.isNotEmpty) {
      if (passC.text == confirmPassC.text) {
        isLoading.value = true;
        if (passC.text != CompanyData.defaultPassword) {
          _updatePassword();
          isLoading.value = false;
        } else {
          CustomToast.errorToast('you_must_change_your_password'.tr);
          isLoading.value = false;
        }
      } else {
        CustomToast.errorToast('password_doesnt_match'.tr);
      }
    } else {
      CustomToast.errorToast('you_need_to_fill_all_fields'.tr);
    }
  }

  void _updatePassword() async {
    try {
      String email = auth.currentUser!.email!;
      await auth.currentUser!.updatePassword(passC.text);
      // relogin
      await auth.signOut();
      await auth.signInWithEmailAndPassword(email: email, password: passC.text);
      Get.offAllNamed(Routes.HOME);

      pageIndexController.changePage(0);
      CustomToast.successToast('update_password_done'.tr);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomToast.errorToast(
            'password_too_weak_you_need_at_least_six_charachter'.tr);
      }
    } catch (e) {
      CustomToast.errorToast('error : ${e.toString()}');
    }
  }
}
