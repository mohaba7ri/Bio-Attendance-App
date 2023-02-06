import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/style/app_color.dart';

import '../controllers/detail_presence_controller.dart';

class DetailPresenceView extends GetView<DetailPresenceController> {
  final Map<String, dynamic> presenceData = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Presence_Detail'.tr,
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 14,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(20),
        physics: BouncingScrollPhysics(),
        children: [
          // check in ============================================
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.secondaryExtraSoft, width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'check_in'.tr,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 4),
                        Text(
                          (presenceData["checkIn"] == null)
                              ? "-"
                              : "${DateFormat.jm().format(DateTime.parse(presenceData["checkIn"]["date"]))}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    //presence date
                    Text(
                      "${DateFormat.yMMMMEEEEd().format(DateTime.parse(presenceData["date"]))}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 14),
                Text(
                  'status'.tr,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  (presenceData["checkIn"]?["in_area"] == true)
                      ? "In_area_presence".tr
                      : "Outside_area_presence".tr,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 14),
                Text(
                  'address'.tr,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  (presenceData["checkIn"] == null)
                      ? "-"
                      : "${presenceData["checkIn"]["address"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 150 / 100,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          // check out ===========================================
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.secondaryExtraSoft, width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'check_out'.tr,
                          style: TextStyle(color: AppColor.secondary),
                        ),
                        SizedBox(height: 4),
                        Text(
                          (presenceData["checkOut"] == null)
                              ? "-"
                              : "${DateFormat.jm().format(DateTime.parse(presenceData["checkOut"]["date"]))}",
                          style: TextStyle(
                              color: AppColor.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    //presence date
                    Text(
                      "${DateFormat.yMMMMEEEEd().format(DateTime.parse(presenceData["date"]))}",
                      style: TextStyle(color: AppColor.secondary),
                    ),
                  ],
                ),
                SizedBox(height: 14),
                Text(
                  'status'.tr,
                  style: TextStyle(color: AppColor.secondary),
                ),
                SizedBox(height: 4),
                Text(
                  (presenceData["checkOut"]?["in_area"] == true)
                        ? "In_area_presence".tr
                      : "Outside_area_presence".tr,
                  style: TextStyle(
                      color: AppColor.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 14),
                Text(
                  'address'.tr,
                  style: TextStyle(color: AppColor.secondary),
                ),
                SizedBox(height: 4),
                Text(
                  (presenceData["checkOut"] == null)
                      ? "-"
                      : "${presenceData["checkOut"]["address"]}",
                  style: TextStyle(
                    color: AppColor.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 150 / 100,
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
