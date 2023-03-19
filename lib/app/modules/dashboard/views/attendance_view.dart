import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../style/app_color.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';
import '../controllers/attendance_controller.dart';

class AttendanceView extends GetView<AttendanceController> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    AttendanceController controller = new AttendanceController();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * 3,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.header),
                  alignment: Alignment.topCenter),
            ),
          ),
          SafeArea(
              child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 64,
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () => Get.back(),
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: AppColor.whiteColor,
                                  )),
                              Text(
                                "Attendance_Summary".tr,
                                style: robotoHugeWhite,
                              )
                            ],
                          ),

                          // Text("vfjk", style: robotoMediumWhite)
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    primary: false,
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              Images.presentEmp,
                              height: 120,
                            ),
                            Text(
                              "total_attendance\n".tr +
                                  '${controller.PresentNumber.toString()}',
                              style: robotoMedium,
                            )
                          ],
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              Images.absentEmp,
                              height: 120,
                            ),
                            Text(
                              "total_absence".tr,
                              style: robotoMedium,
                            )
                          ],
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              Images.approve_ani,
                              height: 120,
                            ),
                            Text(
                              "total_attendance".tr,
                              style: robotoMedium,
                            )
                          ],
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              Images.list,
                              height: 120,
                            ),
                            Text(
                              "total_attendance".tr,
                              style: robotoMedium,
                            )
                          ],
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              Images.vacation,
                              height: 120,
                            ),
                            Text(
                              "total_attendance".tr,
                              style: robotoMedium,
                            )
                          ],
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              Images.leave,
                              height: 120,
                            ),
                            Text(
                              "total_attendance".tr,
                              style: robotoMedium,
                            )
                          ],
                        ),
                      ),
                    ],
                    crossAxisCount: 2,
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
