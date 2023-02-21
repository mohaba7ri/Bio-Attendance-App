import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/app_color.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final title;
  final bool isBackBotton;
  final bool isaction;
  final action;
  const CustomAppBar({
    super.key,
    this.title,
    this.action,
    this.isBackBotton = false,
    this.isaction = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.blackColor,
          )),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      actions: action,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: AppColor.secondaryExtraSoft,
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
