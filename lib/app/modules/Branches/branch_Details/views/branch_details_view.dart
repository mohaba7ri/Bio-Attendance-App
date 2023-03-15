import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';
import '../../../../util/styles.dart';
import '../controllers/branch_details_controller.dart';

final conttroler = Get.put(detailBranchController(), permanent: true);

class detailBranchView extends GetView<detailBranchController> {
  @override
  Widget build(BuildContext context) {
    detailBranchController _detailBranchController = detailBranchController();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Branch_Details'.tr, style: robotoMedium),
        leading: backButton,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 24, 24, 16),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 4, bottom: 12),
                    child: Text(
                      'Branch_Name: '.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4, bottom: 12),
                    child: Text(
                      controller.brancList['name'],
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 4, bottom: 12),
                    child: Text(
                      'Address:'.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4, bottom: 12),
                    child: Text(
                      '${controller.brancList['address']}',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 4, bottom: 12),
                    child: Text(
                      'Active: '.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4, bottom: 12),
                    child: Text(
                      'Yes',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColor.primarySoft,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    //  check in
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 6),
                            child: Text(
                              "Phone".tr,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            '${controller.brancList['phone']}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1.5,
                      height: 24,
                      color: Colors.white,
                    ),
                    // check out
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 6),
                            child: Text(
                              "location".tr,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            'There',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColor.primarySoft,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      //  check in
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 6),
                              child: Text(
                                "latitude".tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'Not available',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1.5,
                        height: 24,
                        color: Colors.white,
                      ),
                      // check out
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 6),
                              child: Text(
                                "longitude".tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'Not available',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 16),
                  decoration: BoxDecoration(
                    // color: AppColor.primarySoft,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      //  check in
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Get.toNamed(Routes.BRACH_SETTING);
                                  },
                                  icon: Icon(Icons.settings_rounded),
                                  label: Text(
                                    'settings'.tr,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                width: double.infinity,
                                height: 100.0),
                          ],
                        ),
                      ),
                      Container(
                        width: 1.5,
                        height: 24,
                        color: Colors.white,
                      ),
                      // check out
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Get.toNamed(Routes.UPDATE_BRANCH,
                                        arguments:
                                            controller.brancList['branchId']);
                                  },
                                  icon: Icon(Icons.edit_rounded),
                                  label: Text(
                                    'Edit_Information'.tr,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                width: double.infinity,
                                height: 100.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
