import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../style/app_color.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../controllers/on_vacation_requests_controller.dart';

class OnVacationView extends GetView<OnVacationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('approved_vac'.tr),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.vacationRequests(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs;

                    return data[index]['days'] == 'please select'
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GetBuilder<OnVacationController>(
                                    builder: (_controller) => Row(
                                      children: [
                                        Row(children: [
                                          ClipOval(
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              child: Image.asset(
                                                Images.userProfile,
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
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 4, bottom: 5),
                                            child: Text('Name'.tr + ' : ',
                                                style: robotoMedium),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 4, bottom: 5),
                                          child: Text(data[index]['userName'],
                                              style: robotoMedium),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 4, bottom: 5),
                                            child: Text(
                                                'Request_Date'.tr + ' : ',
                                                style: robotoMedium),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 4, bottom: 5),
                                          child: Text(
                                              "${DateFormat.yMd().format(DateTime.parse(data[index]['requestDate']))}",
                                              style: robotoMedium),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 2, bottom: 5),
                                          child: Text('Vacation_Type'.tr,
                                              style: robotoMedium),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 2, bottom: 5),
                                          child: Text(
                                              data[index]['vacationType'],
                                              style: robotoMedium),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(children: [
                                      Text(
                                        "attached_files".tr,
                                        style: robotoMedium,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          String fileExtension =
                                              data[index]['file'];

// Use an if statement to check the file extension

                                          if (fileExtension.contains('.pdf')) {
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title:
                                                    Text("attached_files".tr),
                                                content: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  child: SfPdfViewer.network(
                                                    (data[index]['file'] ==
                                                                null ||
                                                            data[index]
                                                                    ['file'] ==
                                                                "")
                                                        ? "https://ui-avatars.com/api/?name=${data[index]['file']}/"
                                                        : data[index]['file'],
                                                    //   fit: BoxFit.cover,
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              14),
                                                      child: const Text("okay"),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title:
                                                    Text("attached_files".tr),
                                                content: ClipRRect(
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height,
                                                    child: Image.network(
                                                      (data[index]['file'] ==
                                                                  null ||
                                                              data[index][
                                                                      'file'] ==
                                                                  "")
                                                          ? "https://ui-avatars.com/api/?name=${data[index]['file']}/"
                                                          : data[index]['file'],
                                                      //   fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              14),
                                                      child: const Text("okay"),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                          // Handle other file types
// }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: AppColor.primary,
                                          ),
                                          width: 90,
                                          height: 30,
                                          child: Center(
                                            child: Text(
                                              data[index]['file'] == 'No file'
                                                  ? "no_file".tr
                                                  : 'file'.tr,
                                              style: robotoMediumWhite,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Icon(Icons.file_present_outlined)
                                    ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 16),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: AppColor.primary,
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
                                                  child: Text("Days".tr,
                                                      style: robotoMediumWhite),
                                                ),
                                                Text(data[index]['days'],
                                                    style: robotoMediumWhite),
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
                                                  margin: EdgeInsets.only(
                                                      bottom: 6),
                                                  child: Text("start_date".tr,
                                                      style: robotoMediumWhite),
                                                ),
                                                Text(
                                                    "${DateFormat.yMMMd().format(DateTime.parse(data[index]["startDate"]))}",
                                                    style: robotoMediumWhite),
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
                                                  margin: EdgeInsets.only(
                                                      bottom: 6),
                                                  child: Text("end_date".tr,
                                                      style: robotoMediumWhite),
                                                ),
                                                Text(
                                                    "${DateFormat.yMMMd().format(DateTime.parse(data[index]["endDate"]))}",
                                                    style: robotoMediumWhite),
                                              ],
                                            ),
                                          ),
                                          // check out
                                        ],
                                      ),
                                    ),
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
      ),
    );
  }
}
