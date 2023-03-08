import 'package:Biometric/app/modules/vacation/view_vacation_requests/views/widgets/filterWidget.dart';
import 'package:Biometric/app/modules/vacation/view_vacation_requests/views/widgets/view_vacation_request_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../style/app_color.dart';
import '../../../../util/styles.dart';
import '../controllers/view_vacation_request_controller.dart';

class ViewVacationRequestView extends GetView<ViewVacationRequestsController> {
  final control = Get.put(ViewVacationRequestsController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    ViewVacationRequestsController _listVacationRequestsController =
        ViewVacationRequestsController();
    return Scaffold(
      backgroundColor: AppColor.greyShade200,
      appBar: AppBar(
        title: Text('Requests'.tr, style: robotoMedium),
        leading: backButton,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [filter(controller: controller)],
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
        child: GetBuilder<ViewVacationRequestsController>(
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
                          stream: _controller.vacationRequests(),
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
                              return Center(
                                child: Text(
                                  'there_are_no_Reqs'.tr,
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
                          stream: _controller.vacationRequests(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            final data = snapshot.data!.docs.where((element) =>
                                element['userName'].toLowerCase().contains(
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
