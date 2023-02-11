import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../style/app_color.dart';

class SearchWideget extends StatelessWidget {
  dynamic data;
  SearchWideget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
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
                    'Vacation_Type'.tr,
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
                            "Days".tr,
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
                            "Start_Date".tr,
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
                            "End_Date".tr,
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