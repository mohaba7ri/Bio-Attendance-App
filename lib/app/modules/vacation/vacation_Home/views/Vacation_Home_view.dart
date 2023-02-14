import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/controllers/page_index_controller.dart';
import 'package:presence/app/style/app_color.dart';

import '../../../../routes/app_pages.dart';
import '../../../../util/images.dart';
import '../../../../widgets/custom_menu_tile.dart';
import '../../../../widgets/custom_widget.dart';
import '../controllers/Vacation_Home_controller.dart';

class VacationHomeView extends GetView<VacationHomeController> {
  final pageIndexController = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
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
                      CustomMenuTile(
                        isDanger: true,
                        title: 'Vacation_Types'.tr,
                        icon: Image.asset(
                          Images.changePassword,
                          color: AppColor.primarySoft,
                        ),
                        onTap: () => Get.toNamed(Routes.VIEW_Vacation_TYPES),
                      ),
                      CustomMenuTile(
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
                      CustomMenuTile(
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
                      CustomMenuTile(
                        isDanger: true,
                        title: 'View_Vacation_Requests'.tr,
                        icon: Image.asset(
                          Images.request,
                          color: AppColor.primarySoft,
                        ),
                        onTap: () {
                          Get.toNamed(Routes.LIST_VIEW_REQUESTS);
                        },
                      ),
                      CustomMenuTile(
                        isDanger: true,
                        title: 'Employees_on_Vacation'.tr,
                        icon: Image.asset(
                          Images.editProfile,
                          color: AppColor.primarySoft,
                        ),
                        onTap: () {
                          Get.toNamed(Routes.ON_VACATION);
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
