import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/style/app_color.dart';

import 'dinmensions.dart';

final robotoRegular = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeDefault,
);

final   robotoMedium = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: Dimensions.fontSizeLarge,
    color: AppColor.blackColor);

final robotoMediumWhite = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: Dimensions.fontSizeLarge,
    color: AppColor.whiteColor);

final robotoBold = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.fontSizeDefault,
);

final robotoHuge = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.fontSizeExtraLarge,
);

final robotoBlack = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w900,
  fontSize: Dimensions.fontSizeDefault,
);
final elevatedButStyle = ElevatedButton.styleFrom(
    fixedSize: const Size(90, 30),
    backgroundColor: Colors.blue,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
final redElevatedButStyle = ElevatedButton.styleFrom(
    fixedSize: const Size(90, 30),
    backgroundColor: Colors.redAccent,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
final backButton = IconButton(
    onPressed: () => Get.back(),
    icon: Icon(
      Icons.arrow_back_ios,
      color: AppColor.blackColor,
    ));
