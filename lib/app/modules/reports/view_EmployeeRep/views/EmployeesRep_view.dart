import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';
import '../../../../util/images.dart';
import '../../../languages/controller/languages_controller.dart';
import '../controllers/EmployeesRep_controller.dart';

class ListEmployeeRepView extends GetView<ListEmployeeRepController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'choose_emp'.tr,
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.delete<ListEmployeeRepController>();
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
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
      body: GetBuilder<ListEmployeeRepController>(
        builder: (_controller) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onSaved: (value) {
                  print(value);
                },
                onChanged: (value) {
                  _controller.changeSearchValue(value);
                },
                // controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search".tr,
                    hintText: "",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: Container(
                color: AppColor.greyShade200,
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _controller.Employee(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print('the error${snapshot.error}');
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data!.docs == null) {
                      return SizedBox();
                    }

                    final data = snapshot.data!.docs.where((element) =>
                        element['name']
                            .toLowerCase()
                            .contains(_controller.searchValue.toLowerCase()));

                    return _controller.searchValue == ''
                        ? SizedBox()
                        : ListView(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: data
                                .map((data) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.EMP_REPORTS,
                                            arguments: data);
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(15, 24, 24, 16),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 10)
                                          ],
                                        ),
                                        child: ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 5.0,
                                                    vertical: 1.0),
                                            leading: Container(
                                              padding:
                                                  EdgeInsets.only(right: 12.0),
                                              decoration: new BoxDecoration(
                                                  border: new Border(
                                                      right: new BorderSide(
                                                          width: 2.0,
                                                          color:
                                                              Colors.black))),
                                              child: Image.asset(Images.profile,
                                                  color: Colors.black),
                                            ),
                                            title: Text(
                                              data['name'],
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
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(data['job'],
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                )
                                              ],
                                            ),
                                            trailing:
                                                GetBuilder<LanguagesController>(
                                              builder: (controller) => Icon(
                                                controller.isLtr == false
                                                    ? Icons.keyboard_arrow_left
                                                    : Icons
                                                        .keyboard_arrow_right,
                                              ),
                                            )),
                                      ),
                                    )))
                                .toList(),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
