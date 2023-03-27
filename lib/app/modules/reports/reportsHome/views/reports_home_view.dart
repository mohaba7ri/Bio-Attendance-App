import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';
import '../../../../util/images.dart';
import '../../../../widgets/custom_menu_tile.dart';
import '../../../../widgets/custom_widget.dart';
import '../controllers/reports_home_controller.dart';

class ReportsHomeView extends GetView<ReportsHomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: CustomeWidget(
        title: 'reports'.tr,
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

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 16, bottom: 30),
                            child: Text(
                              userData["name"],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            userData["job"],
                            style: TextStyle(color: AppColor.secondarySoft),
                          ),
                        ],
                      ),
                      // section 2 - menu

                      userData["role"] == 'Employee'
                          ? SizedBox()
                          : CustomMenuTile(
                              isDanger: true,
                              title: 'all_emps_rep'.tr,
                              icon: Image.asset(
                                Images.employess,
                              ),
                              onTap: () => Get.toNamed(Routes.ALL_EMPS_REP),
                            ),
                      userData["role"] == 'Employee'
                          ? SizedBox()
                          : CustomMenuTile(
                              isDanger: true,
                              title: 'emp_rep'.tr,
                              icon: Image.asset(
                                Images.emp_one,
                              ),
                              onTap: () {
                                Get.toNamed(Routes.LIST_EMPLOYEES_REP,
                                    arguments: userData);
                              },
                            ),
                      userData["role"] == 'Employee'
                          ? SizedBox()
                          : CustomMenuTile(
                              isDanger: true,
                              title: 'all_branches_rep'.tr,
                              icon: Image.asset(
                                Images.branches,
                              ),
                              onTap: () => Get.toNamed(Routes.ALL_BRANCHES_REP),
                            ),
                      userData["role"] == 'Employee'
                          ? SizedBox()
                          : CustomMenuTile(
                              isDanger: true,
                              title: 'branche_rep'.tr,
                              icon: Image.asset(
                                Images.branch,
                              ),
                              onTap: () {
                                Get.toNamed(Routes.LIST_BRANCHES_REP,
                                    arguments: userData);
                              },
                            ),
                      CustomMenuTile(
                        isDanger: true,
                        title: 'generate_report'.tr,
                        icon: Image.asset(
                          Images.emp_one,
                        ),
                        onTap: () {
                          Get.toNamed(Routes.MY_REPORT, arguments: userData);
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
