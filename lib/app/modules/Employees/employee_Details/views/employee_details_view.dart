import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../style/app_color.dart';
import '../controllers/employee_details_controller.dart';

class EmployeeDetailView extends StatelessWidget {
  /// final updateEmployee = Get.put(UpdateEmployeeController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employee_Details'.tr,
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
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
      body: GetBuilder<EmployeeDetailController>(
        builder: (controller) => Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.grey[200],
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
                        'Name: '.tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(top: 4, bottom: 12),
                        child: Text(
                          controller.EmpList['name'],
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                          ),
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
                        '${controller.EmpList['address']}',
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
                        '${controller.EmpList['status']}',
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
                        'Job: '.tr,
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
                        '${controller.EmpList['job']}',
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
                        'Branch: '.tr,
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
                        '${controller.branchName}',
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
                Divider(),
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
                                "Email".tr,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              '${controller.EmpList['email']}',
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
                                'Phone'.tr,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              '${controller.EmpList['phone']}',
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
                      // color: AppColor.primarySoft,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        //  check in

                        // check out
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      // controller.EmpList =
                                      //     snapshot.data!.docs[index];
                                      controller.getBranch();
                                      print(controller.EmpList['name']);
                                      // Get.toNamed(Routes.EMP_UPDATE);
                                    },
                                    icon: Icon(Icons.edit_rounded),
                                    label: Text(
                                      'edit_information'.tr,
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
      ),
    );
  }
}
