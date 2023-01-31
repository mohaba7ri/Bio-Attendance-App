import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';
import '../controllers/employee_details_controller.dart';

final controller = Get.put(employeeDetailController(), permanent: true);

class employeeDetailView extends GetView<employeeDetailController> {
  /// final updateEmployee = Get.put(UpdateEmployeeController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    employeeDetailController _employeeDetailController =
        employeeDetailController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employee Details',
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
      body: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.grey[200],
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 24, 24, 16),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white70,
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
                      'Name: ',
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
                      controller.EmpList['name'],
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
                      'Address:',
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
                      'Status: ',
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
                      'Job: ',
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
              // Row(
              //   children: [
              //     Container(
              //       margin: EdgeInsets.only(top: 4, bottom: 12),
              //       child: Text(
              //         'Branch: ',
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontFamily: 'poppins',
              //           fontSize: 18,
              //           fontWeight: FontWeight.w700,
              //           letterSpacing: 2,
              //         ),
              //       ),
              //     ),
              //     Container(
              //       margin: EdgeInsets.only(top: 4, bottom: 12),
              //       child: Text(
              //         '${controller.EmpList['branchId']}',
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontFamily: 'Inter',
              //           fontSize: 18,
              //           fontWeight: FontWeight.w700,
              //           letterSpacing: 2,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Divider(),

              Container(
                child: StreamBuilder(
                  stream: controller.getBranchName(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }

                    return ListView(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        children: snapshot.data!.docs.map(
                          (DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Branch',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                              ),
                                              Icon(
                                                Icons.access_time_outlined,
                                                size: 30,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            "${controller.EmpList['name']}", //  "${data["branchId"]}", //date[index]['phone'],
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 2,
                                  ),
                                ],
                              ),
                            );
                          },
                        ).toList());
                  },
                ),
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
                              "Email",
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
                              'Phone',
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

                                    print(controller.EmpList['name']);
                                    Get.toNamed(Routes.EMP_UPDATE);
                                  },
                                  icon: Icon(Icons.edit_rounded),
                                  label: Text(
                                    'Edit Information',
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
