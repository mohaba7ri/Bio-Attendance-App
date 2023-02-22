import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';
import 'package:presence/app/style/app_color.dart';
import 'package:presence/app/widgets/custom_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/biometric_controller.dart';
import '../../../util/styles.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  var biometricController = Get.find<BiometricController>();
  final SharedPreferences sharedPreferences;
  LoginView({required this.sharedPreferences});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.primary,
        body: CustomeWidget(
            backButton: false,
            mainWidget: Container(
                color: Colors.white,
                child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      Column(children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 24),
                                child: Text(
                                  'sign_in'.tr,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding:
                                  EdgeInsets.only(left: 14, right: 14, top: 4),
                              margin: EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 1,
                                    color: AppColor.secondaryExtraSoft),
                              ),
                              child: TextField(
                                style: TextStyle(
                                    fontSize: 14, fontFamily: 'poppins'),
                                maxLines: 1,
                                controller: controller.emailC,
                                decoration: InputDecoration(
                                  label: Text("email".tr, style: robotoMedium),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: InputBorder.none,
                                  hintText: "youremail@email.com",
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.secondarySoft,
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(
                                    left: 14, right: 14, top: 4),
                                margin: EdgeInsets.only(bottom: 24),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 1,
                                      color: AppColor.secondaryExtraSoft),
                                ),
                                child: Obx(
                                  () => TextField(
                                    style: TextStyle(
                                        fontSize: 14, fontFamily: 'poppins'),
                                    maxLines: 1,
                                    controller: controller.passC,
                                    obscureText: controller.obsecureText.value,
                                    decoration: InputDecoration(
                                      label: Text("password".tr,
                                          style: robotoMedium),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      border: InputBorder.none,
                                      hintText: "*************",
                                      suffixIcon: IconButton(
                                        icon: (controller.obsecureText != false)
                                            ? SvgPicture.asset(
                                                'assets/icons/show.svg')
                                            : SvgPicture.asset(
                                                'assets/icons/hide.svg'),
                                        onPressed: () {
                                          controller.obsecureText.value =
                                              !(controller.obsecureText.value);
                                        },
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.secondarySoft,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () => Container(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (biometricController.isEnabled ==
                                        false) {
                                      if (controller.isLoading.isFalse) {
                                        await controller.login();
                                        // await controller.getUserToken(FirebaseAuth
                                        //     .instance.currentUser!.uid);
                                      }
                                    } else if (biometricController.isEnabled ==
                                        true) {
                                      biometricController.fingerprintLogin();
                                      // String user = sharedPreferences
                                      //     .getString('userId')!;
                                      // String uid =
                                      //     sharedPreferences.getString(user)!;
                                      // print('the userid $user');
                                      // print('UID$uid');
                                    }
                                  },
                                  child: Text(
                                    (controller.isLoading.isFalse)
                                        ? 'sign_in'.tr
                                        : 'Loading'.tr,
                                    style: robotoMediumWhite,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 18),
                                    backgroundColor: AppColor.primary,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 4),
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () =>
                                    Get.toNamed(Routes.FORGOT_PASSWORD),
                                child: Text("forgot_your_password".tr),
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColor.secondarySoft,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Admin'),
                                IconButton(
                                  onPressed: () {
                                    controller.emailC.text =
                                        'codetech2023@gmail.com'; // 'codetech2023@gmail.com';
                                    controller.passC.text = "123456";
                                  },
                                  icon: Icon(Icons.copy_outlined),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Employee'),
                                IconButton(
                                  onPressed: () {
                                    controller.emailC.text =
                                        'en.ameenalsharafi@gmail.com'; // 'codetech2023@gmail.com';
                                    controller.passC.text = "123456";
                                  },
                                  icon: Icon(Icons.copy_outlined),
                                ),
                              ],
                            )
                          ],
                        ),
                      ])
                    ]))));
  }
}
