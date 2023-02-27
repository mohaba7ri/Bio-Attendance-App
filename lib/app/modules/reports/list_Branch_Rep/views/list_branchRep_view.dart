import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/modules/languages/controller/languages_controller.dart';
import 'package:presence/app/util/images.dart';
import 'package:presence/app/util/styles.dart';

import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';
import '../controllers/list_branchRep_controller.dart';

class listBranchRepView extends GetView<listBranchRepController> {
  @override
  Widget build(BuildContext context) {
    listBranchRepController _listBranchRepController =
        listBranchRepController();
    return Scaffold(
      backgroundColor: AppColor.greyColor,
      appBar: AppBar(
        title: Text('choose_branch'.tr, style: robotoMedium),
        leading: backButton,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.HOME),
            icon: Icon(Icons.home),
            color: AppColor.blackColor,
          )
        ],
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
          stream: _listBranchRepController.branch(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs;

                    return data[index]['name'] == 'name'
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                onTap: () {
                                  print(snapshot.data!.docs[index]['name']);
                                  Get.toNamed(Routes.BRANCH_REP,
                                      arguments: data[index]);
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(15, 24, 24, 16),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                                        data[index]['name'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Row(
                                        children: <Widget>[
                                          Icon(Icons.linear_scale,
                                              color: Colors.yellowAccent),
                                          Text(data[index]['address'],
                                              style: TextStyle(
                                                  color: Colors.black))
                                        ],
                                      ),
                                      trailing: GetBuilder<LanguagesController>(
                                        builder: (controller) => Icon(
                                          controller.isLtr == false
                                              ? Icons.keyboard_arrow_left
                                              : Icons.keyboard_arrow_right,
                                        ),
                                      )),
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