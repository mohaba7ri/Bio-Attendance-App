
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../style/app_color.dart';
import '../util/dinmensions.dart';
import '../util/images.dart';
import '../util/styles.dart';

class MenuTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final void Function() onTap;
  final bool isDanger;
  MenuTile({
    required this.title,
    required this.icon,
    required this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColor.secondaryExtraSoft,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              margin: EdgeInsets.only(right: 24),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.primaryExtraSoft,
                borderRadius: BorderRadius.circular(100),
              ),
              child: icon,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColor.secondary,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 24),
              child: SvgPicture.asset(
                'assets/icons/arrow-right.svg',
                color: (isDanger == false)
                    ? AppColor.secondary
                    : AppColor.tealShade300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileBgWidget extends StatelessWidget {
  final Widget circularImage;
  final Widget mainWidget;
  final bool backButton;
  final void Function() backRout;
  ProfileBgWidget(
      {required this.mainWidget,
      required this.circularImage,
      required this.backButton,
      required this.backRout});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(clipBehavior: Clip.none, children: [
        Center(
          child: Container(
            width: Dimensions.WEB_MAX_WIDTH,
            height: 260,
            color: AppColor.tealShade300,
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
            'ُEmployees'.tr,
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
          child: circularImage,
        ),
      ]),
      Expanded(
        child: mainWidget,
      ),
    ]);
  }
}