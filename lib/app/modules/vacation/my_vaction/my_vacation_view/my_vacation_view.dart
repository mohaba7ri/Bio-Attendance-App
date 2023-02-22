import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:presence/app/modules/vacation/my_vaction/my_vacation_controller/my_vacation_controller.dart';
import 'package:presence/app/style/app_color.dart';

import '../../../../util/styles.dart';
import '../widgets/floatingContainer.dart';
import '../widgets/vacation_appbar.dart';

class MyVacationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColor.greyShade200,
      appBar: MyVacationAppBar(),
      body: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.7,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(15), right: Radius.circular(15)),
              ),
            ),
          ),
          floatingContainer(),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.32,
              bottom: MediaQuery.of(context).size.height * 0,
              child: GetBuilder<MyVacationController>(
                builder: (controller) => Container(
                  height: MediaQuery.of(context).size.width * 0.7,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: controller.vacationRequests(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        case ConnectionState.active:
                        case ConnectionState.done:
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              dynamic data = snapshot.data!.docs;

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding:
                                        EdgeInsets.fromLTRB(15, 24, 24, 16),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 10)
                                      ],
                                    ),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GetBuilder<MyVacationController>(
                                            builder: (_controller) => Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 4, bottom: 12),
                                                  child: Text(
                                                      'Vacation_Type'.tr,
                                                      style: robotoMedium),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 4, bottom: 12),
                                                  child: Text(
                                                      data[index]
                                                          ['vacationType'],
                                                      style: robotoMedium),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 16),
                                            decoration: BoxDecoration(
                                              color: AppColor.primarySoft,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                //  check in
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 6),
                                                        child: Text(
                                                          "Days".tr,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(data[index]['days'],
                                                          style: robotoMedium),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 1.5,
                                                  height: 24,
                                                  color: Colors.white,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 6),
                                                        child: Text(
                                                          "start_date".tr,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        data[index]
                                                            ['startDate'],
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
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
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 6),
                                                        child: Text(
                                                          "end_date".tr,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        data[index]['endDate'],
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // check out
                                              ],
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                              );
                            },
                          );

                        default:
                          return SizedBox();
                      }
                    },
                  ),
                ),
              ))
        
        ],
      ),
    );
  }
}
