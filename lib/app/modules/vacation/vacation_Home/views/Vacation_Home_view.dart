import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../controllers/page_index_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';
import '../../../../util/images.dart';
import '../../../../widgets/custom_menu_tile.dart';
import '../../../../widgets/custom_widget.dart';
import '../controllers/Vacation_Home_controller.dart';

class VacationHomeView extends GetView<VacationHomeController> {
  final pageIndexController = Get.find<PageIndexController>();
  final SharedPreferences sharedPreferences;
  VacationHomeView({required this.sharedPreferences});
  @override
  Widget build(BuildContext context) {
    String? role = sharedPreferences.getString('role');
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: CustomeWidget(
        backButton: true,
        backRout: () => Get.toNamed(Routes.HOME),
        mainWidget: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamUser(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                Map<String, dynamic> userData = snapshot.data!.data()!;
                return Container(
                  color: AppColor.whiteColor,
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 36),
                    children: [
                      SizedBox(height: 16),
                      role == 'Employee'
                          ? SizedBox()
                          : role == 'Admin'
                              ? SizedBox()
                              : CustomMenuTile(
                                  isDanger: true,
                                  title: 'Vacation_Types'.tr,
                                  icon: Image.asset(
                                    Images.vacationTypes,
                                    color: AppColor.primarySoft,
                                  ),
                                  onTap: () =>
                                      Get.toNamed(Routes.VIEW_Vacation_TYPES),
                                ),
                      role == 'SuperAdmin'
                          ? SizedBox()
                          : CustomMenuTile(
                              isDanger: true,
                              title: 'Add_Vacation_Request'.tr,
                              icon: Image.asset(
                                Images.leave,
                                color: AppColor.primarySoft,
                              ),
                              onTap: () {
                                Get.toNamed(Routes.ADD_VACATION_REQUEST);
                              },
                            ),
                      role == 'SuperAdmin'
                          ? SizedBox()
                          : CustomMenuTile(
                              isDanger: true,
                              title: 'my_vacation'.tr,
                              icon: Image.asset(
                                Images.myVacations,
                                color: AppColor.primarySoft,
                              ),
                              onTap: () {
                                Get.toNamed(Routes.MY_VACATION);
                              },
                            ),
                      role == 'Employee'
                          ? SizedBox()
                          : CustomMenuTile(
                              isDanger: true,
                              title: 'View_Vacation_Requests'.tr,
                              icon: Image.asset(
                                Images.viewVacations,
                                color: AppColor.primarySoft,
                              ),
                              onTap: () {
                                Get.toNamed(Routes.LIST_VIEW_REQUESTS);
                              },
                            ),
                      role == 'Employee'
                          ? SizedBox()
                          : CustomMenuTile(
                              isDanger: true,
                              title: 'View_Cancel_Requests'.tr,
                              icon: Image.asset(
                                Images.viewVacations,
                                color: AppColor.primarySoft,
                              ),
                              onTap: () {
                                Get.toNamed(Routes.LIST_VIEW_REQUESTS);
                              },
                            ),
                      role == 'Employee'
                          ? SizedBox()
                          : CustomMenuTile(
                              isDanger: true,
                              title: 'Employees_on_Vacation'.tr,
                              icon: Image.asset(
                                Images.empOnVac,
                                color: AppColor.primarySoft,
                              ),
                              onTap: () {
                                Get.toNamed(Routes.ON_VACATION,
                                    arguments: userData['userId']);
                              },
                            ),
                      role == 'Employee'
                          ? SizedBox()
                          : CustomMenuTile(
                              isDanger: true,
                              title: 'denied_vac'.tr,
                              icon: Image.asset(
                                Images.deny,
                              ),
                              onTap: () {
                                Get.toNamed(Routes.DEN_VAC,
                                    arguments: userData['userId']);
                              },
                            ),
                      Container(
                        height: 1,
                        color: AppColor.primaryExtraSoft,
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                );

              default:
                return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
