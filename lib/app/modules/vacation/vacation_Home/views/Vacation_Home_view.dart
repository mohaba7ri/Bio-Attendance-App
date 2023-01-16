import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/controllers/page_index_controller.dart';
import 'package:presence/app/style/app_color.dart';

import '../../../../routes/app_pages.dart';
import '../../../../util/images.dart';
import '../../../../widgets/Menu_tile.dart';
import '../controllers/Vacation_Home_controller.dart';

class VacationHomeView extends GetView<VacationHomeController> {
  final pageIndexController = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      //  bottomNavigationBar: CustomBottomNavigationBar(),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              Map<String, dynamic> userData = snapshot.data!.data()!;
              return ProfileBgWidget(
                backRout: () => Get.toNamed(Routes.HOME),
                circularImage: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      border: Border.all(
                          width: 2, color: Theme.of(context).cardColor),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: ClipOval(
                      child: Image.network(
                        (userData["avatar"] == null || userData['avatar'] == "")
                            ? "https://ui-avatars.com/api/?name=${userData['name']}/"
                            : userData['avatar'],
                        fit: BoxFit.cover,
                      ),
                    )),
                backButton: true,
                mainWidget: ListView(
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
                      title: 'Vacation Types',
                      icon: Image.asset(
                        Images.changePassword,
                        color: AppColor.primarySoft,
                        width: 20,
                        height: 20,
                      ),
                      onTap: () => Get.toNamed(Routes.VIEW_Vacation_TYPES),
                    ),
                    MenuTile(
                      isDanger: true,
                      title: 'Add Vacation Request',
                      icon: Image.asset(
                        Images.editProfile,
                        color: AppColor.primarySoft,
                        width: 20,
                        height: 20,
                      ),
                      onTap: () {
                        Get.toNamed(Routes.ADD_VACATION_REQUEST);
                      },
                    ),

                    MenuTile(
                      isDanger: true,
                      title: 'View Vacation Requests',
                      icon: Image.asset(
                        Images.editProfile,
                        color: AppColor.primarySoft,
                        width: 20,
                        height: 20,
                      ),
                      onTap: () {
                        Get.toNamed(Routes.LIST_VIEW_REQUESTS);
                      },
                    ),
                    MenuTile(
                      isDanger: true,
                      title: 'Employees on Vacation',
                      icon: Image.asset(
                        Images.editProfile,
                        color: AppColor.primarySoft,
                        width: 20,
                        height: 20,
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
    );
  }
}
