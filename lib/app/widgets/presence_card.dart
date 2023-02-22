import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/style/app_color.dart';
import 'package:presence/app/util/styles.dart';

class PresenceCard extends StatelessWidget {
  final Map<String, dynamic> userData;
  final Map<String, dynamic>? todayPresenceData;
  final Color color;
  final bool isColor;

  PresenceCard(
      {required this.userData,
      required this.todayPresenceData,
      this.color = AppColor.primary,
      this.isColor = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 24, top: 24, right: 24, bottom: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage('assets/images/pattern-1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // job
          Text(userData["job"],
              style: isColor == true ? robotoMedium : robotoMediumWhite),
          //  Employee ID

          // check in - check out box
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: BoxDecoration(
              color: color,
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
                        child: Text("check_in".tr,
                            style: isColor == true
                                ? robotoMedium
                                : robotoMediumWhite),
                      ),
                      Text(
                          (todayPresenceData?["checkIn"] == null)
                              ? "-"
                              : "${DateFormat.jms().format(DateTime.parse(todayPresenceData!["checkIn"]["date"]))}",
                          style: isColor == true
                              ? robotoMedium
                              : robotoMediumWhite),
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
                        margin: EdgeInsets.only(bottom: 6),
                        child: Text("check_out".tr,
                            style: isColor == true
                                ? robotoMedium
                                : robotoMediumWhite),
                      ),
                      Text(
                          (todayPresenceData?["checkOut"] == null)
                              ? "-"
                              : "${DateFormat.jms().format(DateTime.parse(todayPresenceData!["checkOut"]["date"]))}",
                          style: isColor == true
                              ? robotoMedium
                              : robotoMediumWhite),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
