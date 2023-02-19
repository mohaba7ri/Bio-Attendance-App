import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:presence/app/controllers/page_index_controller.dart';
import 'package:presence/app/util/styles.dart';
import 'package:presence/app/widgets/custom_widget.dart';

import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';
import '../../../../util/images.dart';
import '../../../../widgets/custom_menu_tile.dart';
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
      body: CustomeWidget(
        backButton: true,
        backRout: () => Get.toNamed(Routes.HOME),
        mainWidget: StreamBuilder<QuerySnapshot>(
          stream: companyStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('something went wrong'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              // var easLoading = EasyLoading.instance;
              // easLoading.indicatorColor = AppColor.whiteColor;
              // easLoading.maskColor = Colors.amber;
              // easLoading.backgroundColor = Colors.blue;
              // EasyLoading.show();
              EasyLoading.instance
                ..displayDuration = const Duration(milliseconds: 2000)
                ..loadingStyle =
                    EasyLoadingStyle.custom //This was missing in earlier code
                ..backgroundColor = Colors.red
                ..indicatorColor = Colors.red
                ..maskColor = Colors.red
                ..dismissOnTap = false
                ..textColor = Colors.amber
                ..userInteractions = false;
              EasyLoading.show(status: 'Please wait...');
              Timer(Duration(milliseconds: 1000), () => EasyLoading.dismiss());
            }
            if (snapshot.data == null) {
              return Center(
                child: Text('There is no Data'),
              );
            }

            return Container(
              color: AppColor.whiteColor,
              child: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> companyData =
                      document.data()! as Map<String, dynamic>;
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'welcome_to'.tr +
                              '${companyData['name']}' +
                              'company'.tr,
                          style: robotoMedium,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomMenuTile(
                          title: 'view_details'.tr,
                          icon: Image.asset(
                            Images.details,
                          ),
                          onTap: () => Get.toNamed(Routes.COMPANY_DETAILS,
                              arguments: companyData),
                        ),
                        CustomMenuTile(
                          title: 'edit_information'.tr,
                          icon: Image.asset(
                            color: AppColor.primarySoft,
                            Images.editCom,
                          ),
                          onTap: () {
                            Get.toNamed(
                              Routes.UPDATE_COMPANY,
                              arguments: companyData['companyId'],
                            );
                            print(
                              companyData['companyId'],
                            );
                          },
                        ),
                        CustomMenuTile(
                          title: 'settings'.tr,
                          icon: Image.asset(
                            Images.settings,
                          ),
                          onTap: () {
                            // Get.put(CompanySettingController());
                            Get.lazyPut(
                              () => CompanySettingController(
                                companyId: companyData['companyId'],
                              ),
                            );

                            showDialog(
                                context: context,
                                builder: (context) => CompanySettingView(
                                      companyId: companyData['companyId'],
                                    )).then(
                              (_) => Get.delete<CompanySettingController>(),
                            );
                          },
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
          },
        ),
      ),
    );
  }
}
