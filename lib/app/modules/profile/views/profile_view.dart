import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:presence/app/controllers/page_index_controller.dart';
import 'package:presence/app/style/app_color.dart';

import '../../../routes/app_pages.dart';
import '../../../util/images.dart';
import '../../../widgets/menu_tile.dart';
import '../../../widgets/custom_profile_appbar.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
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
              return CustomProfileAppBar(
                backRout: () => Get.toNamed(Routes.HOME),
                circularImage: Container(
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
                        height: 100,
                        width: 100,
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
                      title: 'Theme',
                      icon: Container(
                        color: Colors.red,
                        child: Icon(
                          Ionicons.sunny,
                          color: Colors.white,
                        ),
                      ),
                      onTap: controller.logout,
                    ),
                    MenuTile(
                      isDanger: true,
                      title: 'Change Password',
                      icon: Image.asset(
                        Images.changePassword,
                        color: AppColor.primary,
                        width: 20,
                        height: 20,
                      ),
                      onTap: () => Get.toNamed(Routes.CHANGE_PASSWORD),
                    ),
                    MenuTile(
                      isDanger: true,
                      title: 'Edit profile',
                      icon: Image.asset(
                        Images.editProfile,
                        color: AppColor.primary,
                        width: 20,
                        height: 20,
                      ),
                      onTap: () {
                        Get.toNamed(Routes.UPDATE_POFILE, arguments: userData);
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
