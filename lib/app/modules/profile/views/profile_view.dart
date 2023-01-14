import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:presence/app/controllers/page_index_controller.dart';
import 'package:presence/app/style/app_color.dart';

import '../../../routes/app_pages.dart';
import '../../../util/dinmensions.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';
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
                        color: AppColor.tealShade300,
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
                        color: AppColor.tealShade300,
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

class MenuTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final void Function() onTap;
  final bool isDanger;
  MenuTile({
    required this.title,
    required this.icon,
    required this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColor.secondaryExtraSoft,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              margin: EdgeInsets.only(right: 24),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.primaryExtraSoft,
                borderRadius: BorderRadius.circular(100),
              ),
              child: icon,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColor.secondary,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 24),
              child: SvgPicture.asset(
                'assets/icons/arrow-right.svg',
                color: (isDanger == false)
                    ? AppColor.secondary
                    : AppColor.tealShade300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileBgWidget extends StatelessWidget {
  final Widget circularImage;
  final Widget mainWidget;
  final bool backButton;
  final void Function() backRout;
  ProfileBgWidget(
      {required this.mainWidget,
      required this.circularImage,
      required this.backButton,
      required this.backRout});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(clipBehavior: Clip.none, children: [
        Center(
          child: Container(
            width: Dimensions.WEB_MAX_WIDTH,
            height: 260,
            color: AppColor.tealShade300,
          ),
        ),
        SizedBox(
          width: context.width,
          height: 260,
          child: Center(
              child: Image.asset(Images.coverAppbar,
                  height: 260,
                  width: Dimensions.WEB_MAX_WIDTH,
                  fit: BoxFit.fill)),
        ),
        Positioned(
          top: 200,
          left: 0,
          right: 0,
          bottom: 0,
          child: Center(
            child: Container(
              width: Dimensions.WEB_MAX_WIDTH,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
                color: Theme.of(context).cardColor,
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 0,
          right: 0,
          child: Text(
            'profile'.tr,
            textAlign: TextAlign.center,
            style: robotoRegular.copyWith(
                fontSize: Dimensions.fontSizeLarge,
                color: Theme.of(context).cardColor),
          ),
        ),
        backButton
            ? Positioned(
                top: MediaQuery.of(context).padding.top,
                left: 10,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios,
                      color: Theme.of(context).cardColor, size: 20),
                  onPressed: backRout,
                ),
              )
            : SizedBox(),
        Positioned(
          top: 150,
          left: 0,
          right: 0,
          child: circularImage,
        ),
      ]),
      Expanded(
        child: mainWidget,
      ),
    ]);
  }
}
