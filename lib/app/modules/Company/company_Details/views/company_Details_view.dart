import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../style/app_color.dart';

import '../controllers/company_Details_controller.dart';

class CompanyDetailsView extends GetView<CompanyDetailsController> {
  final detialEmployee = Get.put(CompanyDetailsController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    CompanyDetailsController _companyDetailsController =
        CompanyDetailsController();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            ' Company Details',
            style: TextStyle(
              color: AppColor.secondary,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColor.blackColor,
            ),
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
        body: GetBuilder<CompanyDetailsController>(
          builder: (controller) => Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                ),
                padding:
                    EdgeInsets.only(left: 24, top: 20, right: 8, bottom: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Name",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                  ),
                                  Icon(Icons.adobe_rounded),
                                ],
                              ),
                              SizedBox(height: 6),
                              Text(
                                controller.companyInfo['name'],
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
                      SizedBox(width: 24),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Email",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                    ),
                                    Icon(Icons.email_outlined),
                                  ],
                                ),
                                SizedBox(height: 6),
                                Text(
                                  controller.companyInfo['email'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      SizedBox(width: 24),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Address",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                    ),
                                    Icon(Icons.location_pin),
                                  ],
                                ),
                                SizedBox(height: 6),
                                Text(
                                  controller.companyInfo['address'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      SizedBox(width: 24),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Phone",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                    ),
                                    Icon(Icons.phone_android_outlined),
                                  ],
                                ),
                                SizedBox(height: 6),
                                Text(
                                  controller.companyInfo['phone'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      SizedBox(width: 24),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Number of Branches",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                    ),
                                    Icon(Icons.numbers_outlined),
                                  ],
                                ),
                                SizedBox(height: 6),
                                Text(
                                  '${controller.branchNumbers.toString()}', //date[index]['phone'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      SizedBox(width: 24),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Number of Employees",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                    ),
                                    Icon(Icons.people_alt_outlined),
                                  ],
                                ),
                                SizedBox(height: 6),
                                Text(
                                  '${controller.userNumbers.toString()}', //date[index]['phone'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      SizedBox(width: 24),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Location",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                    ),
                                    Icon(Icons.location_searching_outlined),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                "Latitude",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColor.blackColor,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Latitude",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColor.blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      StreamBuilder(
                          stream: controller.getCompanySettings(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("Loading");
                            }

                            return ListView(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
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
                                                      'Start Time',
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .access_time_outlined,
                                                      size: 30,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 6),
                                                Text(
                                                  "${DateFormat.jm().format(DateTime.parse(data["startTime"]))}", //date[index]['phone'],
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'End Time',
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .access_time_outlined,
                                                      size: 30,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 6),
                                                Text(
                                                  "${DateFormat.jm().format(DateTime.parse(data["endTime"]))}", //date[index]['phone'],
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
                                                      'Late Time',
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .access_time_outlined,
                                                      size: 30,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 6),
                                                Text(
                                                  "${DateFormat.jm().format(DateTime.parse(data["lateTime"]))}", //date[index]['phone'],
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Overly Time',
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .access_time_outlined,
                                                      size: 30,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 6),
                                                Text(
                                                  "${DateFormat.jm().format(DateTime.parse(data["overlyTime"]))}", //date[index]['phone'],
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList());
                          }),
                      Divider(
                        thickness: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
