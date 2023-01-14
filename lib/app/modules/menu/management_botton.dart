import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/model/menu_model.dart';
import 'package:presence/app/modules/profile/controllers/profile_controller.dart';

import '../../util/dinmensions.dart';

class MenuButton extends StatelessWidget {
  final MenuModel menu;
  final bool isLogout;
  MenuButton({super.key, required this.menu, required this.isLogout});

  @override
  Widget build(BuildContext context) {
    double _size = Dimensions.PADDING_SIZE_DEFAULT;
    return InkWell(
      onTap: () {
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
                ? Get.find<ProfileController>().isLougout == true
                    ? Colors.red
                    : Colors.teal
                : Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 5)
            ],
          ),
          alignment: Alignment.center,
          child: Image.asset(menu.icon,
              width: 20, height: 20, color: Colors.white),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        Text(menu.title,
            //  style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
            textAlign: TextAlign.center),
      ]),
    );
  }
}
