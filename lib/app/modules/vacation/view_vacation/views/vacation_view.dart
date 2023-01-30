import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:presence/app/modules/vacation/view_vacation/controllers/vacation_controller.dart';

import '../../../../style/app_color.dart';
import '../../add_vacation_type/views/add_vacation_type_view.dart';

final conttroler = Get.put(ListVacationTypeController(), permanent: true);

class ListVacationTypeView extends GetView<ListVacationTypeController> {
  @override
  Widget build(BuildContext context) {
    ListVacationTypeController _listVacationTypeController =
        ListVacationTypeController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vacation Types',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 14,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          Container(
            width: 44,
            height: 44,
            margin: EdgeInsets.only(bottom: 8, top: 8, right: 8),
            child: ElevatedButton(
              onPressed: () {
                Get.dialog(
                  Dialog(),
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
          stream: _listVacationTypeController.vacationType(),
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

                    return date[index]['vacationType'] == 'please select'
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(15, 24, 24, 16),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white70,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 5)
                                ],
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 2, bottom: 8),
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
                                          margin: EdgeInsets.only(
                                              top: 2, bottom: 8),
                                          child: Text(
                                            date[index]['vacationType'],
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
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 4, bottom: 12),
                                          child: Text(
                                            'Days:',
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
                                            ' 7',
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 8),
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
                                                  margin: EdgeInsets.only(
                                                      bottom: 6),
                                                  child: Text(
                                                    "Status",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  date[index]['vacationStatus'],
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
                                          // check out
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 6),
                                                  child: Text(
                                                    "Is paid",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
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
                            ),
                          );
                  },
                );
              default:
                return SizedBox();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (_) => AddVacationTypeView());
        },
        child: Icon(Icons.add),
      ),
      // TextButton(
      //   child: Text('Add Vacation Type'),
      //   onPressed: () {
      //     showDialog(context: context, builder: (_) => AddVacationTypeView());
      //   },
      // ),
    );
  }
}
