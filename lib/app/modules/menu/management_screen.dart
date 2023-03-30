import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/menu_model.dart';
import '../../routes/app_pages.dart';
import '../../util/dinmensions.dart';
import '../../util/images.dart';
import 'management_botton.dart';

class ManagementScreen extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  ManagementScreen({super.key, required this.sharedPreferences});
  List<MenuModel>? _menuList;

  @override
  Widget build(BuildContext context) {
    String? role = sharedPreferences.getString('role');
    role == 'Employee'
        ? _menuList = [
            MenuModel(
              icon: Images.vacation,
              title: 'vacation'.tr,
              route: Routes.VACATION_HOME,
            ),

            MenuModel(
                icon: Images.report,
                title: 'reports'.tr,
                route: Routes.REP_HOME),
            MenuModel(
                icon: Images.language,
                title: 'language'.tr,
                route: Routes.LANGUAGES),
            MenuModel(
                icon: Images.userProfile,
                title: 'profile'.tr,
                route: Routes.PROFILE),
            //  MenuModel(icon: Images.office, title: 'company'.tr, route: ''),
            MenuModel(icon: Images.logout, title: 'logout'.tr, route: ''),
          ]
        : role == 'SuperAdmin'
            ? _menuList = [
                MenuModel(
                    icon: Images.office,
                    title: 'company'.tr,
                    route: Routes.COMPANY_HOME),
                MenuModel(
                  icon: Images.branches,
                  title: 'branch'.tr,
                  route: Routes.BRANCH_HOME,
                ),
                MenuModel(
                    icon: Images.employess,
                    title: 'employees'.tr,
                    route: Routes.EMPLOYEE_HOME),
                MenuModel(
                  icon: Images.vacation,
                  title: 'vacation'.tr,
                  route: Routes.VACATION_HOME,
                ),

                MenuModel(
                    icon: Images.report,
                    title: 'reports'.tr,
                    route: Routes.REP_HOME),
                MenuModel(
                    icon: Images.language,
                    title: 'language'.tr,
                    route: Routes.LANGUAGES),
                MenuModel(
                    icon: Images.userProfile,
                    title: 'profile'.tr,
                    route: Routes.PROFILE),
                //  MenuModel(icon: Images.office, title: 'company'.tr, route: ''),
                MenuModel(icon: Images.logout, title: 'logout'.tr, route: ''),
              ]
            : _menuList = [
                MenuModel(
                  icon: Images.branches,
                  title: 'branch'.tr,
                  route: Routes.BRANCH_HOME,
                ),
                MenuModel(
                    icon: Images.employess,
                    title: 'employees'.tr,
                    route: Routes.EMPLOYEE_HOME),
                MenuModel(
                  icon: Images.vacation,
                  title: 'vacation'.tr,
                  route: Routes.VACATION_HOME,
                ),
                // MenuModel(
                //     icon: Images.dashboard,
                //     title: 'dashboard'.tr,
                //     route: Routes.ATTENDANCE),
                MenuModel(
                    icon: Images.report,
                    title: 'reports'.tr,
                    route: Routes.REP_HOME),
                MenuModel(
                    icon: Images.language,
                    title: 'language'.tr,
                    route: Routes.LANGUAGES),
                MenuModel(
                    icon: Images.userProfile,
                    title: 'profile'.tr,
                    route: Routes.PROFILE),
                //  MenuModel(icon: Images.office, title: 'company'.tr, route: ''),
                MenuModel(icon: Images.logout, title: 'logout'.tr, route: ''),
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
