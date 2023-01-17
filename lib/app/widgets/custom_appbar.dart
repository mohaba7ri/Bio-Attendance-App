import 'package:flutter/material.dart';

import '../style/app_color.dart';

class CustomeAppbar extends StatelessWidget {
  final Widget mainWidget;
  final Widget child;
  bool isChild;
  CustomeAppbar({required this.mainWidget, required this.child,this.isChild=false});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 20 / 100,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 32),
          decoration: BoxDecoration(
            color: AppColor.primary,
            image: DecorationImage(
              image: AssetImage('assets/images/pattern-1-1.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: isChild == true ? child : SizedBox(),
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
