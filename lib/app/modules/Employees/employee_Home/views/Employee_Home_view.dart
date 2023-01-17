import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/controllers/page_index_controller.dart';
import 'package:presence/app/widgets/custom_appbar.dart';

import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';
import '../../../../util/images.dart';
import '../../../../widgets/Menu_tile.dart';
import '../controllers/Employee_Home_controller.dart';

class EmployeeHomeView extends GetView<EmployeeHomeController> {
  final pageIndexController = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: CustomeAppbar(
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
                            margin: EdgeInsets.only(top: 16, bottom: 4),
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

                      MenuTile(
                        isDanger: true,
                        title: 'Add Employee',
                        icon: Image.asset(
                          Images.changePassword,
                          color: AppColor.primarySoft,
                          width: 20,
                          height: 20,
                        ),
                        onTap: () => Get.toNamed(Routes.ADD_EMPLOYEE),
                      ),
                      MenuTile(
                        isDanger: true,
                        title: 'View Employees',
                        icon: Image.asset(
                          Images.editProfile,
                          color: AppColor.primarySoft,
                          width: 20,
                          height: 20,
                        ),
                        onTap: () {
                          Get.toNamed(Routes.LIST_EMPLOYEES);
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
