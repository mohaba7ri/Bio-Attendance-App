import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/style/app_color.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../util/images.dart';
import '../../../../../util/styles.dart';
import '../../controllers/view_vacation_request_controller.dart';
import '../acceptDenay_buttons.dart';

class ViewVacationRequestWidget extends StatelessWidget {
  final data;
  final index;
  final isIndex;
  ViewVacationRequestWidget(
      {Key? key, required this.data, this.index, this.isIndex = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          // Get.toNamed(Routes.MANAGE_VACATION,
          //     arguments:
          //         snapshot.data!.docs[index]);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 2, 2, 1),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      margin: EdgeInsets.only(top: 4, bottom: 5),
                      child: Text('Name'.tr + ' : ', style: robotoMedium),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4, bottom: 5),
                    child: Text(
                        isIndex == true
                            ? ' ${data[index]['userName']}'
                            : ' ${data['userName']}',
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
                    margin: EdgeInsets.only(top: 2, bottom: 5),
                    child: Text('Vacation_Type'.tr, style: robotoMedium),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2, bottom: 5),
                    child: Text(
                        isIndex == true
                            ? data[index]['vacationType']
                            : data['vacationType'],
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
                    // Future<void> downloadFileExample() async {
                    //   //First you get the documents folder location on the device...
                    //   Directory appDocDir =
                    //       await getApplicationDocumentsDirectory();
                    //   //Here you'll specify the file it should be saved as
                    //   File downloadToFile =
                    //       File('${appDocDir.path}/downloaded-pdf.pdf');
                    //   //Here you'll specify the file it should download from Cloud Storage
                    //   String fileToDownload =
                    //       "https://ui-avatars.com/api/?name=${data[index]['file']}";

                    //   //Now you can try to download the specified file, and write it to the downloadToFile.

                    //   await firebase_storage.FirebaseStorage.instance
                    //       .ref(fileToDownload)
                    //       .writeToFile(downloadToFile);
                    // }

                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text("attached_files".tr),
                        content: ClipRRect(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: //Image.network(
                                SfPdfViewer.network(
                              // 'https://firebasestorage.googleapis.com/v0/b/biometri-app.appspot.com/o/vacationRequest%2F2.pdf?alt=media&token=9f3d09f8-4cb1-4fc0-9c29-c7ba3ac6a88c'
                              (data[index]['file'] == null ||
                                      data[index]['file'] == "")
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
                      borderRadius: BorderRadius.circular(10.0),
                      color: AppColor.primary,
                    ),
                    width: 90,
                    height: 30,
                    child: Center(
                      child: Text(
                        isIndex == true
                            ? data[index]['file'] == 'No file'
                                ? "no_file".tr
                                : 'file'.tr
                            : data['file'] == 'No file'
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
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColor.primary,
                ),
                child: Row(
                  children: [
                    //  check in
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 6),
                            child: Text("Days".tr, style: robotoMediumWhite),
                          ),
                          Text(
                              isIndex == true
                                  ? data[index]['days']
                                  : data['days'],
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
                            margin: EdgeInsets.only(bottom: 6),
                            child:
                                Text("start_date".tr, style: robotoMediumWhite),
                          ),
                          Text(
                              isIndex == true
                                  ? data[index]['startDate']
                                  : data['startDate'],
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
                            margin: EdgeInsets.only(bottom: 6),
                            child:
                                Text("end_date".tr, style: robotoMediumWhite),
                          ),
                          Text(
                              isIndex == true
                                  ? data[index]['endDate']
                                  : data['endDate'],
                              style: robotoMediumWhite),
                        ],
                      ),
                    ),
                    // check out
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: acceptDeny_buttons(index),
            ),
          ]),
        ),
      ),
    );
  }
}
