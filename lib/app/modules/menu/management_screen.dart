import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:presence/app/model/menu_model.dart';
import 'package:presence/app/modules/menu/management_botton.dart';

import '../../routes/app_pages.dart';
import '../../util/dinmensions.dart';
import '../../util/images.dart';

class ManagementScreen extends StatelessWidget {
  ManagementScreen({super.key});
  List<MenuModel>? _menuList;

  @override
  Widget build(BuildContext context) {
    _menuList = [
      MenuModel(
          icon: Images.office, title: 'Company', route: Routes.COMPANY_HOME),
      MenuModel(
        icon: Images.office,
        title: 'Branch',
        route: Routes.BRANCH_HOME,
      ),
      MenuModel(
          icon: Images.employess,
          title: 'Employees',
          route: Routes.EMPLOYEE_HOME),
      MenuModel(
        icon: Images.profile,
        title: 'vacation',
        route: Routes.VACATION_HOME,
      ),
      MenuModel(
          icon: Images.office,
          title: 'Attendance',
          route: Routes.ADD_COMPANY_SETTING),
      MenuModel(
          icon: Images.employess, title: 'Reports', route: Routes.ADD_EMPLOYEE),
      MenuModel(
          icon: Images.office, title: 'Language', route: Routes.ADD_BRANCH),
      MenuModel(icon: Images.profile, title: 'profile', route: Routes.PROFILE),
      MenuModel(
          icon: Images.office,
          title: 'Company',
          route: Routes.ADD_COMPANY_SETTING),
      MenuModel(
          icon: Images.employess,
          title: 'Employees',
          route: Routes.ADD_EMPLOYEE),
      MenuModel(icon: Images.office, title: 'Branch', route: Routes.ADD_BRANCH),
      MenuModel(icon: Images.logout, title: 'Logout', route: ''),
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
                return MenuButton(
                  menu: _menuList![index],
                  isLogout: index == _menuList!.length - 1,
                );
              }),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
        ]),
      ),
    );
  }
}
