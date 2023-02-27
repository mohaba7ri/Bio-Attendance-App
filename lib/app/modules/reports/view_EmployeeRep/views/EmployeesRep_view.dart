import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';
import '../../../vacation/view_vacation_requests/views/widgets/view_vacation_request_widget.dart';
import '../controllers/EmployeesRep_controller.dart';

class ListEmployeeRepView extends GetView<ListEmployeeRepController> {
  @override
  Widget build(BuildContext context) {
    ListEmployeeRepController _listEmployeeRepController =
        ListEmployeeRepController();
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
        child: GetBuilder<ListEmployeeRepController>(
          builder: (_controller) => Container(
            child: SingleChildScrollView(
              child: Column(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                    ),
                  ),
                  controller.searchValue == ''
                      ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: _controller.Employee(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              print('the error${snapshot.error}');
                              return const Text('Something went wrong');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.data!.docs.isEmpty) {
                              return const Center(
                                child: Text(
                                  'There is No Data !',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      letterSpacing: 1.5,
                                      color: Colors.blueGrey,
                                      fontFamily: 'Acme',
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }
                            dynamic data = snapshot.data!.docs;
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  dynamic data = snapshot.data!.docs;
                                  return ViewVacationRequestWidget(
                                    data: data,
                                    index: index,
                                    isIndex: true,
                                  );
                                });
                          },
                        )
                      : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: _controller.Employee(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            final data = snapshot.data!.docs.where((element) =>
                                element['name'].toLowerCase().contains(
                                    _controller.searchValue.toLowerCase()));
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Center(
                                    child: CircularProgressIndicator());
                              case ConnectionState.active:
                              case ConnectionState.done:
                                return ListView(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  children: data
                                      .map((e) => ViewVacationRequestWidget(
                                            data: e,
                                          ))
                                      .toList(),
                                );
                              default:
                                return SizedBox();
                            }
                          },
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
