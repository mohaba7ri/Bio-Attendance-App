import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';
import '../controllers/list_vacation_requests_controller.dart';

class ListVacationRequestView extends GetView<ListVacationRequestsController> {
  final control = Get.put(ListVacationRequestsController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    ListVacationRequestsController _listVacationRequestsController =
        ListVacationRequestsController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Requests',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 14,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
        backgroundColor: Colors.grey[200],
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
      body: GetBuilder<ListVacationRequestsController>(
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
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
                controller.searchValue == ''
                    ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream:
                            _listVacationRequestsController.vacationRequests(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());
                            case ConnectionState.active:
                            case ConnectionState.done:
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  dynamic date = snapshot.data!.docs;

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        // control.vacationRequest =
                                        //     snapshot.data!.docs[index];

                                        // print(control.vacationRequest['vacationType']);
                                        Get.toNamed(Routes.Req_DETAILS);
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
                                                      'Vacation Type: ',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'poppins',
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        letterSpacing: 2,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 4, bottom: 12),
                                                    child: Text(
                                                      date[index]
                                                          ['vacationType'],
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'poppins',
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        letterSpacing: 2,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 16),
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
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: 6),
                                                            child: Text(
                                                              "Days",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            date[index]['days'],
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.white,
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
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: 6),
                                                            child: Text(
                                                              "Start Date",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            date[index]
                                                                ['startDate'],
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.white,
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
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: 6),
                                                            child: Text(
                                                              "End Date",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            date[index]
                                                                ['endDate'],
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // check out
                                                  ],
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  );
                                },
                              );
                            default:
                              return SizedBox();
                          }
                        },
                      )
                    : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream:
                            _listVacationRequestsController.vacationRequests(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          final data = snapshot.data!.docs.where((element) =>
                              element['vacationType'].contains(
                                  _controller.searchValue.toLowerCase()));
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());
                            case ConnectionState.active:
                            case ConnectionState.done:
                              return ListView(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                children: data
                                    .map((e) => SearchWideget(data: e))
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
    );
  }
}

class SearchWideget extends StatelessWidget {
  dynamic data;
  SearchWideget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          // control.vacationRequest =
          //     snapshot.data!.docs[index];

          // print(control.vacationRequest['vacationType']);
          Get.toNamed(Routes.Req_DETAILS);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 24, 24, 16),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 4, bottom: 12),
                  child: Text(
                    'Vacation Type: ',
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
                  margin: EdgeInsets.only(top: 4, bottom: 12),
                  child: Text(
                    data['vacationType'],
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
                          margin: EdgeInsets.only(bottom: 6),
                          child: Text(
                            "Days",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          data['days'],
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
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 6),
                          child: Text(
                            "Start Date",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          data['startDate'],
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
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 6),
                          child: Text(
                            "End Date",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          data['endDate'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // check out
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class filter extends StatelessWidget {
  const filter({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ListVacationRequestsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      margin: EdgeInsets.only(bottom: 8, top: 8, right: 8),
      child: ElevatedButton(
        onPressed: () {
          Get.dialog(
            Dialog(
              child: Container(
                height: 372,
                child: SfDateRangePicker(
                  headerHeight: 50,
                  headerStyle:
                      DateRangePickerHeaderStyle(textAlign: TextAlign.center),
                  monthViewSettings:
                      DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                  selectionMode: DateRangePickerSelectionMode.range,
                  selectionColor: AppColor.primary,
                  rangeSelectionColor: AppColor.primary.withOpacity(0.2),
                  viewSpacing: 10,
                  showActionButtons: true,
                  onCancel: () => Get.back(),
                  onSubmit: (data) {
                    if (data != null) {
                      PickerDateRange range = data as PickerDateRange;
                      if (range.endDate != null) {
                        controller.pickDate(range.startDate!, range.endDate!);
                      }
                    }
                    //else skip
                  },
                ),
              ),
            ),
          );
        },
        child: SvgPicture.asset('assets/icons/filter.svg'),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
