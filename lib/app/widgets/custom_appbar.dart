import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/app_color.dart';
import '../util/dinmensions.dart';
import '../util/images.dart';
import '../util/styles.dart';

class CustomAppBar extends StatelessWidget {
   Widget? circularImage;
   late Widget? mainWidget;
   bool backButton;
   void Function()? backRout;
  CustomAppBar(
      { this.mainWidget,
      this.circularImage,
      required this.backButton,
       this.backRout});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(clipBehavior: Clip.none, children: [
        Center(
          child: Container(
            width: Dimensions.WEB_MAX_WIDTH,
            height: 260,
            color: AppColor.primary,
          ),
        ),
        SizedBox(
          width: context.width,
          height: 260,
          child: Center(
              child: Image.asset(Images.coverAppbar,
                  height: 260,
                  width: Dimensions.WEB_MAX_WIDTH,
                  fit: BoxFit.fill)),
        ),
        Positioned(
          top: 200,
          left: 0,
          right: 0,
          bottom: 0,
          child: Center(
            child: Container(
              width: Dimensions.WEB_MAX_WIDTH,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
                color: Theme.of(context).cardColor,
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 0,
          right: 0,
          child: Text(
            'profile'.tr,
            textAlign: TextAlign.center,
            style: robotoRegular.copyWith(
                fontSize: Dimensions.fontSizeLarge,
                color: Theme.of(context).cardColor),
          ),
        ),
        backButton
            ? Positioned(
                top: MediaQuery.of(context).padding.top,
                left: 10,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios,
                      color: Theme.of(context).cardColor, size: 20),
                  onPressed: backRout,
                ),
              )
            : SizedBox(),
        Positioned(
          top: 150,
          left: 0,
          right: 0,
          child: circularImage!,
        ),
      ]),
     mainWidget==null?SizedBox(): Expanded(
        child: mainWidget!,
      ),
    ]);
  }
}
