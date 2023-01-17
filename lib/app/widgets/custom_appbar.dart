import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/app_color.dart';
import '../util/dinmensions.dart';
import '../util/images.dart';

class CustomeAppbar extends StatelessWidget {
  final Widget mainWidget;
  bool backButton;
  Function()? backRout;
  CustomeAppbar({required this.mainWidget, this.backButton = false,this.backRout});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Container(
                width: Dimensions.WEB_MAX_WIDTH,
                height: MediaQuery.of(context).size.height * 25 / 100,
                color: AppColor.primary,
              ),
            ),
            SizedBox(
              width: context.width,
              height: MediaQuery.of(context).size.height * 25 / 100,
              child: Center(
                  child: Image.asset(Images.coverAppbar,
                      height: MediaQuery.of(context).size.height * 25 / 100,
                      width: Dimensions.WEB_MAX_WIDTH,
                      fit: BoxFit.fill)),
            ),
            backButton == true
                ? Positioned(
                    top: MediaQuery.of(context).padding.top,
                    left: 10,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          color: AppColor.whiteColor, size: 20),
                      onPressed:backRout!=null?backRout: ()=>Get.back(),
                    ),
                  )
                : SizedBox(),
          ],
        ),
        Container(
          height: 20,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        ),
        Expanded(
          child: mainWidget,
        ),
      ],
    );
  }
}
