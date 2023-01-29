import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:presence/app/util/images.dart';

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
      body: Container(
        color: Colors.grey[200],
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12, blurRadius: 10)
                                    ],
                                  ),
                                  child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 5.0, vertical: 1.0),
                                      leading: Container(
                                        padding: EdgeInsets.only(right: 12.0),
                                        decoration: new BoxDecoration(
                                            border: new Border(
                                                right: new BorderSide(
                                                    width: 2.0,
                                                    color: Colors.black))),
                                        child: Image.asset(Images.office,
                                            color: Colors.black),
                                      ),
                                      title: Text(
                                        date[index]['name'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Row(
                                        children: <Widget>[
                                          Icon(Icons.linear_scale,
                                              color: Colors.yellowAccent),
                                          Text(date[index]['address'],
                                              style: TextStyle(
                                                  color: Colors.black))
                                        ],
                                      ),
                                      trailing: Icon(Icons.keyboard_arrow_right,
                                          color: Colors.black, size: 30.0)),
                                )),
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
