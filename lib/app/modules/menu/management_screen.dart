import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:presence/app/model/menu_model.dart';

import '../../routes/app_pages.dart';
import '../../util/dinmensions.dart';
import 'management_botton.dart';

class ManagementScreen extends StatelessWidget {
  ManagementScreen({super.key});
  List<MenuModel>? _menuList;

  @override
  Widget build(BuildContext context) {
    _menuList = [
      MenuModel(icon: '', title: 'profile', route: Routes.profile),
      MenuModel(icon: '', title: 'profile', route: Routes.profile),
      MenuModel(icon: '', title: 'profile', route: Routes.profile),
      MenuModel(icon: '', title: 'profile', route: Routes.profile),
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: Icon(Icons.keyboard_arrow_down_rounded, size: 30),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: Dimensions.PADDING_SIZE_EXTRA_SMALL, mainAxisSpacing: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                ),
                itemCount: _menuList!.length,
                 itemBuilder: (context,index){
                    return MenuButton(menu: _menuList![index],);
                 }),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL ),
          ],
        ),
      ),
    );
  }
}
