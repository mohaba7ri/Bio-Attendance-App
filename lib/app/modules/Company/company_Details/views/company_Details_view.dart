import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            Icons.arrow_back_ios_new_outlined,
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
      body: Container(
        // color: Colors.blueGrey[300],
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _companyDetailsController.Company(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    var date = snapshot.data!.docs;

                    return date[index]['name'] == 'name'
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                //color: Colors.blueAccent[100],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 2,
                                  color: AppColor.blackColor,
                                ),
                              ),
                              padding: EdgeInsets.only(
                                  left: 24, top: 20, right: 8, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Name",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                              ),
                                              Icon(Icons.adobe_rounded),
                                            ],
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            date[index]['name'],
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Email",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0),
                                                ),
                                                Icon(Icons.email_outlined),
                                              ],
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              date[index]['email'],
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Address",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0),
                                                ),
                                                Icon(Icons.location_pin),
                                              ],
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              date[index]['address'],
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Phone",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0),
                                                ),
                                                Icon(Icons
                                                    .phone_android_outlined),
                                              ],
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              date[index]['phone'],
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Number of Branches",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0),
                                                ),
                                                Icon(Icons.numbers_outlined),
                                              ],
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              '2', //date[index]['phone'],
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Number of Employees",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0),
                                                ),
                                                Icon(Icons.people_alt_outlined),
                                              ],
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              '12', //date[index]['phone'],
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Location",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0),
                                                ),
                                                Icon(Icons
                                                    .location_searching_outlined),
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
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Start Time",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                              '12', //date[index]['phone'],
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
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "End Time",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0),
                                                ),
                                                Icon(
                                                  Icons.av_timer_outlined,
                                                  size: 30,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              '12', //date[index]['phone'],
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
                                ],
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
    );
  }
}
