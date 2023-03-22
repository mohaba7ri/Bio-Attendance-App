import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../style/app_color.dart';
import '../../../../../util/images.dart';
import '../../../../../util/styles.dart';
import '../../controllers/company_Details_controller.dart';

class DraggableScreen extends GetView<CompanyDetailsController> {
  final detialEmployee = Get.put(CompanyDetailsController(), permanent: true);

  @override
  @override
  Widget build(BuildContext context) {
    CompanyDetailsController _companyDetailsController =
        CompanyDetailsController();
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 1.0,
        minChildSize: 0.6,
        builder: (context, scrollController) {
          return GetBuilder<CompanyDetailsController>(
              builder: (controller) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      controller: scrollController,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 25),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 5,
                                    width: 35,
                                    color: Colors.black12,
                                  )
                                ],
                              ),
                            ),
                            Text(
                              'Company_Details'.tr,
                              style: robotoHuge,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Name".tr + ': ',
                                  style: robotoMedium,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  controller.companyInfo['name'],
                                  style: robotoMedium,
                                ),
                                Spacer(),
                                Image.asset(
                                  Images.info,
                                  width: 25,
                                  height: 25,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Phone".tr + ': ',
                                  style: robotoMedium,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  controller.companyInfo['phone'],
                                  style: robotoMedium,
                                ),
                                Spacer(),
                                Icon(
                                  Icons.phone_android_outlined,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Email".tr + ': ',
                                  style: robotoMedium,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  controller.companyInfo['email'],
                                  style: robotoMedium,
                                ),
                                Spacer(),
                                Icon(
                                  Icons.email_outlined,
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Divider(
                                height: 4,
                              ),
                            ),
                            Row(children: [
                              Text(
                                "address".tr + ': ',
                                style: robotoHuge,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                controller.companyInfo['address'],
                                style: robotoMedium,
                              ),
                            ]),
                            const SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: controller.launchOfficeOnMap,
                              child: Container(
                                height: 84,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColor.primaryExtraSoft,
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/map.JPG'),
                                    fit: BoxFit.cover,
                                    opacity: 0.3,
                                  ),
                                ),
                                child: Text(
                                  'Open_in_maps'.tr,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Divider(
                                height: 4,
                              ),
                            ),
                            Text("Branches_Employees".tr, style: robotoHuge),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  elevation: 4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        Images.viewEmps,
                                        height: 60,
                                      ),
                                      Text(
                                        "employees\n".tr +
                                            '${controller.userNumbers.toString()}',
                                        style: robotoMedium,
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  elevation: 4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        Images.branches,
                                        height: 60,
                                      ),
                                      Text(
                                        "branches\n".tr +
                                            '${controller.branchNumbers.toString()}',
                                        style: robotoMedium,
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Divider(
                                height: 4,
                              ),
                            ),
                            Text("General_Settings".tr, style: robotoHuge),
                            // SingleChildScrollView(
                            //   scrollDirection: Axis.horizontal,
                            //   child:
                            StreamBuilder(
                              stream: controller.getBranchSettings(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text("Loading".tr);
                                }

                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: ListView(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(),
                                        children: snapshot.data!.docs
                                            .map((DocumentSnapshot document) {
                                          Map<String, dynamic> data = document
                                              .data()! as Map<String, dynamic>;
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                elevation: 4,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.more_time_outlined,
                                                      size: 60,
                                                      color: AppColor.primary,
                                                    ),
                                                    Text(
                                                      'Start_Time'.tr,
                                                      style: robotoMedium,
                                                    ),
                                                    Text(
                                                      "${DateFormat.jm().format(DateTime.parse(data["startTime"]))}",
                                                      style: robotoMedium,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                elevation: 4,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.av_timer_rounded,
                                                      size: 60,
                                                      color: AppColor.primary,
                                                    ),
                                                    Text(
                                                      'End_Time'.tr,
                                                      style: robotoMedium,
                                                    ),
                                                    Text(
                                                      '6'.tr,
                                                      style: robotoMedium,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                elevation: 4,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons
                                                          .share_arrival_time_outlined,
                                                      size: 60,
                                                      color: AppColor.primary,
                                                    ),
                                                    Text(
                                                      'Late_Time'.tr,
                                                      style: robotoMedium,
                                                    ),
                                                    Text(
                                                      '6'.tr,
                                                      style: robotoMedium,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                elevation: 4,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.more_time_outlined,
                                                      size: 60,
                                                      color: AppColor.primary,
                                                    ),
                                                    Text(
                                                      'Overly_Time'.tr,
                                                      style: robotoMedium,
                                                    ),
                                                    Text(
                                                      '6'.tr,
                                                      style: robotoMedium,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                            ],
                                          );
                                        }).toList()));

                                //SizedBox();
                              },
                            )
                          ]))));
        });
    //               //  Row(
    //               //   mainAxisAlignment: MainAxisAlignment.center,
    //               //   children: [
    //               //     Card(
    //               //       shape: RoundedRectangleBorder(
    //               //           borderRadius: BorderRadius.circular(8)),
    //               //       elevation: 4,
    //               //       child: Column(
    //               //         mainAxisAlignment: MainAxisAlignment.center,
    //               //         children: <Widget>[
    //               //           Icon(
    //               //             Icons.more_time_outlined,
    //               //             size: 60,
    //               //             color: AppColor.primary,
    //               //           ),
    //               //           Text(
    //               //             'Start_Time'.tr,
    //               //             style: robotoMedium,
    //               //           ),
    //               //           Text(
    //               //             "${DateFormat.jm().format(DateTime.parse(data["startTime"]))}",
    //               //             style: robotoMedium,
    //               //           )
    //               //         ],
    //               //       ),
    //               //     ),
    //               //     const SizedBox(
    //               //       width: 20,
    //               //     ),
    //               //     Card(
    //               //       shape: RoundedRectangleBorder(
    //               //           borderRadius: BorderRadius.circular(8)),
    //               //       elevation: 4,
    //               //       child: Column(
    //               //         mainAxisAlignment: MainAxisAlignment.center,
    //               //         children: <Widget>[
    //               //           Icon(
    //               //             Icons.av_timer_rounded,
    //               //             size: 60,
    //               //             color: AppColor.primary,
    //               //           ),
    //               //           Text(
    //               //             'End_Time'.tr,
    //               //             style: robotoMedium,
    //               //           ),
    //               //           Text(
    //               //             '6'.tr,
    //               //             style: robotoMedium,
    //               //           )
    //               //         ],
    //               //       ),
    //               //     ),
    //               //     const SizedBox(
    //               //       width: 20,
    //               //     ),
    //               //     Card(
    //               //       shape: RoundedRectangleBorder(
    //               //           borderRadius: BorderRadius.circular(8)),
    //               //       elevation: 4,
    //               //       child: Column(
    //               //         mainAxisAlignment: MainAxisAlignment.center,
    //               //         children: <Widget>[
    //               //           Icon(
    //               //             Icons.share_arrival_time_outlined,
    //               //             size: 60,
    //               //             color: AppColor.primary,
    //               //           ),
    //               //           Text(
    //               //             'Late_Time'.tr,
    //               //             style: robotoMedium,
    //               //           ),
    //               //           Text(
    //               //             '6'.tr,
    //               //             style: robotoMedium,
    //               //           )
    //               //         ],
    //               //       ),
    //               //     ),
    //               //     const SizedBox(
    //               //       width: 20,
    //               //     ),
    //               //     Card(
    //               //       shape: RoundedRectangleBorder(
    //               //           borderRadius: BorderRadius.circular(8)),
    //               //       elevation: 4,
    //               //       child: Column(
    //               //         mainAxisAlignment: MainAxisAlignment.center,
    //               //         children: <Widget>[
    //               //           Icon(
    //               //             Icons.more_time_outlined,
    //               //             size: 60,
    //               //             color: AppColor.primary,
    //               //           ),
    //               //           Text(
    //               //             'Overly_Time'.tr,
    //               //             style: robotoMedium,
    //               //           ),
    //               //           Text(
    //               //             '6'.tr,
    //               //             style: robotoMedium,
    //               //           )
    //               //         ],
    //               //       ),
    //               //     ),
    //               //     const SizedBox(
    //               //       width: 20,
    //               //     ),
    //               //   ],
    //               // ),

    //             //),
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
    // });
  }
}
