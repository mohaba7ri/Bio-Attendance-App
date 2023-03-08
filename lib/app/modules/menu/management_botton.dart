import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../model/menu_model.dart';
import '../../util/dinmensions.dart';
import '../../util/images.dart';
import '../../widgets/dialog/custom_alert_dialog.dart';
import '../home/controllers/home_controller.dart';
import '../profile/controllers/profile_controller.dart';

class MenuButton extends StatelessWidget {
  final profileController = Get.find<ProfileController>();
  final homeController = Get.find<HomeController>();
  final MenuModel menu;
  final bool isLogout;
  MenuButton({super.key, required this.menu, required this.isLogout});

  @override
  Widget build(BuildContext context) {
    final SharedPreferences sharedPreferences = Get.find();
    double _size = Dimensions.PADDING_SIZE_DEFAULT;
    return InkWell(
      onTap: () {
        if (isLogout) {
          Get.back();
          CustomAlertDialog.customAlert(
              icon: Images.support,
              message: 'sure'.tr,
              onConfirm: () {
                profileController.logout();
              },
              onCancel: () => Get.back());
        } else
          Get.toNamed(menu.route);
      },
      child: Column(children: [
        Container(
          height: 50,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          margin:
              EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            color: isLogout
                ? Get.find<ProfileController>().isLogout()
                    ? Colors.red
                    : Colors.blue
                : Theme.of(context).primaryColorDark,
            boxShadow: [
              BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 5)
            ],
          ),
          alignment: Alignment.center,
          child: Image.asset(
            menu.icon,
            width: 20,
            height: 20,
            color: Colors.white,
          ),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        Text(menu.title,
            //  style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
            textAlign: TextAlign.center),
      ]),
    );
  }
}
