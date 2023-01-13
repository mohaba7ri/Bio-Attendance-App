import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:presence/app/model/menu_model.dart';
import 'package:presence/app/modules/menu/management_botton.dart';

import '../../routes/app_pages.dart';
import '../../util/dinmensions.dart';

class ManagementScreen extends StatelessWidget {
  ManagementScreen({super.key});
  List<MenuModel>? _menuList;

  @override
  Widget build(BuildContext context) {
    _menuList = [
      MenuModel(
          icon: '', title: 'profile', route: Routes.profile),
      MenuModel(
          icon: '', title: 'profile', route: Routes.profile),
      MenuModel(
          icon: '', title: 'profile', route: Routes.profile),
      MenuModel(
          icon: '', title: 'profile', route: Routes.profile),
    ];
    return PointerInterceptor(
      child: Container(
        width: Dimensions.WEB_MAX_WIDTH,
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Theme.of(context).cardColor,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          InkWell(
            onTap: () => Get.back(),
            child: Icon(Icons.keyboard_arrow_down_rounded, size: 30),
          ),
          GridView.builder(
              shrinkWrap: true,
              itemCount: _menuList!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1,
                crossAxisSpacing: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return MenuButton(menu: _menuList![index]);
              }),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
        ]),
      ),
    );
  }
}
