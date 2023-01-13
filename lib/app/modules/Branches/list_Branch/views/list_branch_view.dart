import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';
import '../../branch_Details/controllers/branch_details_controller.dart';
import '../controllers/list_branch_controller.dart';

class listBranchView extends GetView<listBranchController> {
  final detialBranch = Get.put(detailBranchController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    listBranchController _listBranchController = listBranchController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Branches',
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _listBranchController.branch(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var date = snapshot.data!.docs;

                  return date[index]['name'] == 'name'
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                               
                               detialBranch.brancList =
                                    snapshot.data!.docs[index];
                               
                                print(detialBranch.brancList['name']);
                                 Get.toNamed(Routes.Branch_Details);
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(15, 24, 24, 16),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColor.containerColor,
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 4, bottom: 12),
                                            child: Text(
                                              'Branch Name: ',
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
                                            margin: EdgeInsets.only(
                                                top: 4, bottom: 12),
                                            child: Text(
                                              date[index]['name'],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'poppins',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              // IconButton(
                                              //   alignment: Alignment.centerLeft,
                                              //   onPressed: () {
                                              //     // Get.toNamed(
                                              //     //     Routes.Branch_Options);
                                              //     showDialog(
                                              //       context: context,
                                              //       builder:
                                              //           (BuildContext context) {
                                              //         return AlertDialog(
                                              //           title: Text(
                                              //               'Choose an option'),
                                              //           actions: [
                                              //             ElevatedButton(
                                              //                 onPressed: () {
                                              //                   Get.toNamed(Routes
                                              //                       .Update_Branch);
                                              //                 },
                                              //                 child: Text(
                                              //                     "Branch Settings")),
                                              //             ElevatedButton(
                                              //                 onPressed: () {
                                              //                   Get.toNamed(Routes
                                              //                       .Update_Branch);
                                              //                 },
                                              //                 child: Text(
                                              //                     "Edit Information")),
                                              //           ],
                                              //         );
                                              //       },
                                              //     );
                                              //   },
                                              //   icon: Icon(
                                              //       Icons.settings_outlined),
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 4, bottom: 12),
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
                                            margin: EdgeInsets.only(
                                                top: 4, bottom: 12),
                                            child: Text(
                                              snapshot.data!.docs[index]
                                                  ['address'],
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
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                            // check out
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 6),
                                                    child: Text(
                                                      "location",
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
                                                      fontWeight:
                                                          FontWeight.w700,
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
                              )),
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
