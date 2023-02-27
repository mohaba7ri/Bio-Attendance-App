import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/util/images.dart';

import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';
import '../../../languages/controller/languages_controller.dart';
import '../controllers/Employees_controller.dart';

class ListEmployeeView extends GetView<ListEmployeeController> {
  @override
  Widget build(BuildContext context) {
    ListEmployeeController _listEmployeeController = ListEmployeeController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employees'.tr,
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
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.HOME),
            icon: Icon(Icons.home),
            color: AppColor.blackColor,
          )
        ],
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
        color: AppColor.greyShade200,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _listEmployeeController.Employee(),
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
                        : 
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.EMP_DETAIL,
                                    arguments: snapshot.data!.docs[index]);
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
                                child:
                                 ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 1.0),
                                    leading: Container(
                                      padding: EdgeInsets.only(right: 12.0),
                                      decoration: new BoxDecoration(
                                          border: new Border(
                                              right: new BorderSide(
                                                  width: 2.0,
                                                  color: Colors.black))),
                                      child: Image.asset(Images.profile,
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
                                        Icon(Icons.work_outline,
                                            color: Colors.black),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(date[index]['job'],
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                    trailing: GetBuilder<LanguagesController>(
                                      builder: (controller) => Icon(
                                        controller.isLtr == false
                                            ? Icons.keyboard_arrow_left
                                            : Icons.keyboard_arrow_right,
                                      ),
                                    )),
                             
                              ),
                            ));
                 
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
