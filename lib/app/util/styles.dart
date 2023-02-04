import 'package:flutter/material.dart';

import 'dinmensions.dart';

final robotoRegular = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeDefault,
);

final robotoMedium = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeLarge,
);

final robotoBold = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.fontSizeDefault,
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
