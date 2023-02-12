import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/modules/vacation/view_vacation_requests/views/widgets/filterWidget.dart';
import 'package:presence/app/modules/vacation/view_vacation_requests/views/widgets/searchWidget.dart';
import 'package:presence/app/util/styles.dart';

import '../../../../style/app_color.dart';
import '../controllers/view_vacation_request_controller.dart';

class ViewVacationRequestView extends GetView<ViewVacationRequestsController> {
  final control = Get.put(ViewVacationRequestsController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    ViewVacationRequestsController _listVacationRequestsController =
        ViewVacationRequestsController();
    return Scaffold(
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
                          stream: _listVacationRequestsController
                              .vacationRequests(),
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
                            return ViewVacationRequestWidget(
                              data: data,
                              snapshot: snapshot,
                            );
                          },
                        )
                      : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: _listVacationRequestsController
                              .vacationRequests(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            final data = snapshot.data!.docs.where((element) =>
                                element['vacationType'].contains(
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
                                            snapshot: snapshot,
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
