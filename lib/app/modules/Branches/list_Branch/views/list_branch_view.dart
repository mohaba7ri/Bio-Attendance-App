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
      backgroundColor: AppColor.greyColor,
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
                                Get.toNamed(Routes.BRANCH_DETAILS);
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(15, 24, 24, 16),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.containerShedow,
                                      spreadRadius: 5,
                                      blurRadius: 10,
                                    )
                                  ],
                                  color: AppColor.whiteColor,
                                  border:
                                      Border.all(color: AppColor.blackColor),
                                  borderRadius: BorderRadius.circular(8),
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
                                              'Name: ',
                                              style: TextStyle(
                                                color: AppColor.blackColor,
                                                fontFamily: 'poppins',
                                                fontSize: 14,
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
                                                color: AppColor.blackColor,
                                                fontFamily: 'poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w800,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Icon(
                                                (Icons
                                                    .arrow_forward_ios_outlined),
                                                color: AppColor.blackColor,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
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
                                                color: AppColor.blackColor,
                                                fontFamily: 'poppins',
                                                fontSize: 16,
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
                                                color: AppColor.blackColor,
                                                fontFamily: 'poppins',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ),
                                        ],
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
