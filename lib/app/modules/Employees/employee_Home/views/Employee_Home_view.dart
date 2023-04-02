import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/page_index_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';
import '../../../../util/images.dart';
import '../../../../widgets/custom_menu_tile.dart';
import '../../../../widgets/custom_widget.dart';
import '../controllers/Employee_Home_controller.dart';

class EmployeeHomeView extends GetView<EmployeeHomeController> {
  final pageIndexController = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: CustomeWidget(
        title: 'Employee_Management'.tr,
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

                      CustomMenuTile(
                        isDanger: true,
                        title: 'Add_Employee'.tr,
                        icon: Image.asset(
                          Images.addEmp,
                        ),
                        onTap: () => Get.toNamed(Routes.ADD_EMPLOYEE,
                            arguments: userData),
                      ),
                      CustomMenuTile(
                        isDanger: true,
                        title: 'View_Employees'.tr,
                        icon: Image.asset(
                          Images.viewEmps,
                        ),
                        onTap: () {
                          Get.toNamed(Routes.LIST_EMPLOYEES,
                              arguments: userData);
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
