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
            fontSize: 16,
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                            margin: EdgeInsets.all(40),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Color(0xFF94CCF9),
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF04589A),
                                  offset: Offset(7, 7),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 4, bottom: 12),
                                        child: Text(
                                          'Name: ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 4, bottom: 12),
                                        child: Text(
                                          date[index]['name'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 4, bottom: 12),
                                        child: Text(
                                          'Email:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 4, bottom: 12),
                                        child: Text(
                                          snapshot.data!.docs[index]['name'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 16),
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
                                                margin:
                                                    EdgeInsets.only(bottom: 6),
                                                child: Text(
                                                  "Phone",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                date[index]['phone'],
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
                                                margin:
                                                    EdgeInsets.only(bottom: 6),
                                                child: Text(
                                                  "Address",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                date[index]['address'],
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
                                ]),
                          ),
                        );
                },
              );

            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
