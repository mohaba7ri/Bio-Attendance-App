import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../style/app_color.dart';
import '../../../../../util/images.dart';
import '../../../../../util/styles.dart';
import '../../controllers/view_vacation_request_controller.dart';
import '../acceptDenay_buttons.dart';

class ViewVacationRequestWidget extends StatelessWidget {
  final data;
  final snapshot;
  ViewVacationRequestWidget(
      {Key? key, required this.data, required this.snapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        dynamic data = snapshot.data!.docs;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              // Get.toNamed(Routes.MANAGE_VACATION,
              //     arguments:
              //         snapshot.data!.docs[index]);
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 24, 24, 16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetBuilder<ViewVacationRequestsController>(
                      builder: (_controller) => Row(
                        children: [
                          Row(children: [
                            ClipOval(
                              child: Container(
                                width: 50,
                                height: 50,
                                child: Image.asset(
                                  Images.profile,
                                  // (controller.VacList["avatar"] == null ||
                                  //         controller.VacList['avatar'] == "")
                                  //     ? "https://ui-avatars.com/api/?name=${controller.VacList['userName']}/"
                                  //     : controller.VacList['avatar'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ]),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              margin: EdgeInsets.only(top: 4, bottom: 12),
                              child:
                                  Text('Name'.tr + ' : ', style: robotoMedium),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4, bottom: 12),
                            child: Text('${data[index]['userName']}',
                                style: robotoMedium),
                          ),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(top: 4, bottom: 12),
                            child:
                                Text('Vacation_Type'.tr, style: robotoMedium),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4, bottom: 12),
                            child: Text(data[index]['vacationType'],
                                style: robotoMedium),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        Text(
                          "attached_files".tr,
                          style: robotoHuge,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text("attached_files".tr),
                                content: ClipRRect(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: Image.network(
                                      (data[index]['file'] == null ||
                                              data[index]['file'] == "")
                                          ? "https://ui-avatars.com/api/?name=${data[index]['file']}/"
                                          : data[index]['file'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(14),
                                      child: const Text("okay"),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.primarySoft,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: 200,
                            height: 30,
                            child: Text(
                              data[index]['file'] != null
                                  ? data[index]['file']
                                  : '',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
                                      "Days".tr,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(data[index]['days'],
                                      style: robotoMedium),
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
                                      "Start_Date".tr,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    data[index]['startDate'],
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
                                      "End_Date".tr,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    data[index]['endDate'],
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: acceptDeny_buttons(),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }
}
