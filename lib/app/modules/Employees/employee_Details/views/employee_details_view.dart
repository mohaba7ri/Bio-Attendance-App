import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/widgets/presence_card.dart';

import '../../../../style/app_color.dart';
import '../../../../widgets/custom_appbar.dart';
import '../controllers/employee_details_controller.dart';

class EmployeeDetailView extends GetView<EmployeeDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'details',
        
        isColor: true,
        color: AppColor.primary,
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
              top: MediaQuery.of(context).size.height * 0.18,
              left: MediaQuery.of(context).size.width * 0.03,
              right: MediaQuery.of(context).size.width * 0.03,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(10, 10)),
                    ],
                    color: AppColor.greyColor,
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
                                  padding: const EdgeInsets.all(8.0),
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
              top: MediaQuery.of(context).size.height * 0.40,
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
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: AppColor.whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10,
                                          offset: Offset(10, 10)),
                                    ]),
                                child: Row(
                                  children: [Text(_controller.EmpList['name'])],
                                )),
                          )
                        ],
                      ))))
        ],
      ),
    );
  }
}
