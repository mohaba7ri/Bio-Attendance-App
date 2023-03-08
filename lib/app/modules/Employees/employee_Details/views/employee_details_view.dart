import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_input.dart';
import '../../../../widgets/presence_card.dart';
import '../../employee_Update/controllers/update_employee_controller.dart';
import '../controllers/employee_details_controller.dart';

class EmployeeDetailView extends GetView<EmployeeDetailController> {
  final updateEmp = Get.put(UpdateEmployeeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'details'.tr,
        isColor: true,
        color: AppColor.primary,
        action: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.EMP_UPDATE,
                    arguments: updateEmp.EmpDetail['userId']);
               // print(updateEmp.EmpDetail['userId']);
              },
              icon: Icon(Icons.edit))
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.7,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.10,
              left: MediaQuery.of(context).size.width * 0.03,
              right: MediaQuery.of(context).size.width * 0.03,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(10, 10)),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                          stream: controller.streamUser(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Somthing went wrong');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (!snapshot.hasData) {
                              return Center(
                                child: Text('There is no Data'),
                              );
                            }
                            Map<String, dynamic> user = snapshot.data!.data()!;

                            return StreamBuilder(
                              stream: controller.streamTodayPresence(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Somthing went wrong');
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: Text('There is no Data'),
                                  );
                                }

                                var todayPresenceData = snapshot.data?.data();
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: PresenceCard(
                                      userData: user,
                                      isColor: true,
                                      color: AppColor.whiteColor,
                                      todayPresenceData: todayPresenceData),
                                );
                              },
                            );
                          })
                    ],
                  ),
                ),
              )),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            bottom: MediaQuery.of(context).size.height * 0,
            child: GetBuilder<EmployeeDetailController>(
              builder: (_controller) => Container(
                height: MediaQuery.of(context).size.width * 0.7,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: Offset(10, 10)),
                            ]),
                        child: Column(
                          children: [
                            // Text(_controller.EmpList['name']),

                            CustomInput(
                              controller: controller.nameC,
                              label: 'Full_Name'.tr,
                              hint: '',
                              disabled: true,
                            ),
                            CustomInput(
                              controller: controller.emailC,
                              label: 'email'.tr,
                              hint: '',
                              disabled: true,
                            ),
                            CustomInput(
                              controller: controller.jobC,
                              label: 'Job'.tr,
                              hint: '',
                              disabled: true,
                            ),
                            CustomInput(
                              controller: controller.addressC,
                              label: 'Address'.tr,
                              hint: '',
                              disabled: true,
                            ),
                            CustomInput(
                              controller: controller.phoneC,
                              label: 'Phone'.tr,
                              hint: '',
                              disabled: true,
                            ),
                            CustomInput(
                              keyboardType: TextInputType.number,
                              controller: controller.salaryPerHour,
                              label: 'salary_per_hour'.tr,
                              hint: '',
                              disabled: true,
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
        ],
      ),
    );
  }
}
