import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../style/app_color.dart';

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
                    : AppColor.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
