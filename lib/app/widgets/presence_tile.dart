import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../routes/app_pages.dart';
import '../style/app_color.dart';
import '../util/styles.dart';

class PresenceTile extends StatelessWidget {
  final Map<String, dynamic> presenceData;
  PresenceTile({required this.presenceData});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.DETAIL_PRESENCE, arguments: presenceData),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: AppColor.primaryExtraSoft,
          ),
        ),
        padding: EdgeInsets.only(left: 24, top: 20, right: 8, bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("check_in".tr, style: robotoMedium),
                    SizedBox(height: 6),
                    Text(
                        (presenceData["checkIn"] == null)
                            ? "-"
                            : "${DateFormat.jm().format(DateTime.parse(presenceData["checkIn"]["date"]))}",
                        style: robotoMedium),
                  ],
                ),
                SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("check_out".tr, style: robotoMedium),
                    SizedBox(height: 6),
                    Text(
                      (presenceData["checkOut"] == null)
                          ? "-"
                          : "${DateFormat.jm().format(DateTime.parse(presenceData["checkOut"]["date"]))}",
                      style: robotoMedium,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                "${DateFormat.yMMMMEEEEd().format(DateTime.parse(presenceData["date"]))}",
                style: TextStyle(
                  fontSize: 10,
                  color: AppColor.secondarySoft,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
