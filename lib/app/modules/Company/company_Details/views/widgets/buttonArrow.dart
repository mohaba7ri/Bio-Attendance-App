import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../../style/app_color.dart';

buttonArrow(BuildContext) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 55,
          width: 55,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 30,
                  color: AppColor.whiteColor,
                ),
              )),
        ),
      ),
    );
  }
