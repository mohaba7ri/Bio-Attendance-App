import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../style/app_color.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../my_vacation_controller/my_vacation_controller.dart';

class floatingContainer extends StatelessWidget {
  const floatingContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.05,
      left: MediaQuery.of(context).size.width * 0.03,
      right: MediaQuery.of(context).size.width * 0.03,
      // bottom: MediaQuery.of(context).size.width * 0.99,
      child: GetBuilder<MyVacationController>(
        builder: (controller) => Container(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.27,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(10, 10)),
                ]),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "you_requests_history".tr,
                        style: robotoBlack,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: Row(
                    children: [
                      //  check in
                      Expanded(
                        child: Column(
                          children: [
                            Image.asset(
                              Images.list,
                              width: 40,
                              height: 40,
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 2),
                              child: Text("total_requests".tr,
                                  style: robotoMedium),
                            ),
                            Text('${controller.vacationsNumber.toString()}',
                                style: robotoMedium),
                          ],
                        ),
                      ),
                      Container(
                        width: 1.5,
                        height: 60,
                        color: AppColor.primary,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            // ImageIcon(AssetImage(
                            //   Images.approved,
                            // )),
                            Image.asset(
                              Images.approve_ani,
                              width: 40,
                              height: 40,
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 2),
                              child: Text("approved".tr, style: robotoMedium),
                            ),
                            Text('${controller.approvedNumber.toString()}',
                                style: robotoMedium),
                          ],
                        ),
                      ),
                      Container(
                        width: 1.5,
                        height: 60,
                        color: AppColor.primary,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Image.asset(
                              Images.deny_ani,
                              width: 40,
                              height: 40,
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 2),
                              child: Text("denied".tr, style: robotoMedium),
                            ),
                            Text('${controller.deniedNumber.toString()}',
                                style: robotoMedium),
                          ],
                        ),
                      ),
                      // check out
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
