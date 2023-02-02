import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/controllers/page_index_controller.dart';
import 'package:presence/app/widgets/custom_appbar.dart';

import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';
import '../../../../util/images.dart';
import '../../../../widgets/Menu_tile.dart';
import '../../company_settings/controller/company_seting_controlleer.dart';
import '../../company_settings/view/company_setting_view.dart';
import '../controllers/Company_Home_controller.dart';

class CompanyHomeView extends GetView<CompanyHomeController> {
  final pageIndexController = Get.find<PageIndexController>();

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> companyStream =
        FirebaseFirestore.instance.collection('company').snapshots();
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: CustomeAppbar(
        backButton: true,
        backRout: () => Get.toNamed(Routes.HOME),
        mainWidget: StreamBuilder<QuerySnapshot>(
          stream: companyStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                return Container(
                  color: AppColor.whiteColor,
                  child: ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> companyData =
                          document.data()! as Map<String, dynamic>;
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'welcome_to :\n'.tr +
                                  '${companyData['name']}' +
                                  'company'.tr,
                              style: TextStyle(
                                  color: AppColor.secondarySoft,
                                  fontFamily: 'cairo',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            MenuTile(
                              isDanger: true,
                              title: 'view_details'.tr,
                              icon: Image.asset(
                                Images.changePassword,
                                color: AppColor.primarySoft,
                                width: 20,
                                height: 20,
                              ),
                              onTap: () => Get.toNamed(Routes.COMPANY_DETAILS,
                                  arguments: companyData),
                            ),
                            MenuTile(
                              isDanger: true,
                              title: 'edit_information'.tr,
                              icon: Image.asset(
                                Images.editProfile,
                                color: AppColor.primarySoft,
                                width: 20,
                                height: 20,
                              ),
                              onTap: () {
                                Get.toNamed(Routes.UPDATE_COMPANY,
                                    arguments: companyData['companyId']);
                                print(companyData['companyId']);
                              },
                            ),
                            MenuTile(
                              isDanger: true,
                              title: 'settings'.tr,
                              icon: Image.asset(
                                Images.editProfile,
                                color: AppColor.primarySoft,
                                width: 20,
                                height: 20,
                              ),
                              onTap: () {
                                // Get.put(CompanySettingController());
                                Get.lazyPut(() => CompanySettingController(
                                    companyId: companyData['companyId']));

                                showDialog(
                                    context: context,
                                    builder: (context) => CompanySettingView(
                                          companyId: companyData['companyId'],
                                        )).then((_) =>
                                    Get.delete<CompanySettingController>());
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
                    }).toList(),
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
