import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/modules/vacation/view_vacation/controllers/vacation_controller.dart';

import '../../../../style/app_color.dart';
import '../../add_vacation_type/views/add_vacation_type_view.dart';

final conttroler = Get.put(VacationTypeController(), permanent: true);

class VacationTypeView extends GetView<VacationTypeController> {
  @override
  Widget build(BuildContext context) {
    VacationTypeController _vacationTypeController = VacationTypeController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.brown.shade200,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _vacationTypeController.vacationType(),
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
                              borderRadius: BorderRadius.circular(8),
                              color: AppColor.containerColor,
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 4, bottom: 12),
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
                                        margin:
                                            EdgeInsets.only(top: 4, bottom: 12),
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
                                        margin:
                                            EdgeInsets.only(top: 4, bottom: 12),
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
                                        margin:
                                            EdgeInsets.only(top: 4, bottom: 12),
                                        child: Text(
                                          ' 7',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Inter',
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
                                        horizontal: 8, vertical: 16),
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
                                                margin:
                                                    EdgeInsets.only(bottom: 6),
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
                                                margin:
                                                    EdgeInsets.only(bottom: 6),
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
