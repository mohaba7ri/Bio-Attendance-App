import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/modules/vacation/view_vacation/controllers/vacation_controller.dart';

import '../../../../routes/app_pages.dart';

final conttroler = Get.put(VacationTypeController(), permanent: true);

class VacationTypeView extends GetView<VacationTypeController> {
  @override
  Widget build(BuildContext context) {
    VacationTypeController _vacationTypeController = VacationTypeController();
    return Scaffold(
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(
                              2.0,
                              2.0,
                            ), //Offset
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: Row(
                        children: [
                          Text(snapshot.data!.docs[index]['vacationstatus']),
                          Spacer(),
                          Obx(
                            () => Switch(
                                activeColor: snapshot.data!.docs[index]
                                            ['vacationstatus'] ==
                                        'active'
                                    ? Colors.green
                                    : Colors.red,
                                inactiveThumbColor: Colors.red,
                                value: controller.switchValue.value,
                                onChanged: (value) {
                                  controller.changeSwitchValue(snapshot
                                      .data!.docs[index]['vacationstatus']);
                                  // controller.switchValue.value = value;
                                }),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            default:
              return SizedBox();
          }
        },
      ),
      floatingActionButton: TextButton(
        child: Text('Add Vacation Type'),
        onPressed: () {
          Get.toNamed(
            Routes.ADD_VACATION_TYPE,
          );
        },
      ),
    );
  }
}
