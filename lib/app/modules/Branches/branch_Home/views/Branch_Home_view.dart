import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/controllers/page_index_controller.dart';
import 'package:presence/app/style/app_color.dart';

import '../../../../routes/app_pages.dart';
import '../../../../util/images.dart';
import '../../../../widgets/Menu_tile.dart';
import '../controllers/Branch_Home_controller.dart';

class BranchHomeView extends GetView<BranchHomeController> {
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
                  width: 0,
                  height: 0,
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    border: Border.all(
                        width: 2, color: Theme.of(context).cardColor),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                ),
                backButton: true,
                mainWidget: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  children: [
                    // SizedBox(height: 16),

                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       margin: EdgeInsets.only(top: 16, bottom: 30),
                    //       child: Text(
                    //         userData["name"],
                    //         style: TextStyle(
                    //             fontSize: 16, fontWeight: FontWeight.w500),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // // section 2 - menu

                    MenuTile(
                      isDanger: true,
                      title: 'Add Branch',
                      icon: Image.asset(
                        Images.addBranch,
                        color: AppColor.primarySoft,
                        width: 20,
                        height: 20,
                      ),
                      onTap: () => Get.toNamed(Routes.ADD_BRANCH),
                    ),
                    MenuTile(
                      isDanger: true,
                      title: 'View Branches',
                      icon: Image.asset(
                        Images.viewAll,
                        color: AppColor.primarySoft,
                        width: 20,
                        height: 20,
                      ),
                      onTap: () => Get.toNamed(Routes.list_Branch),
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
