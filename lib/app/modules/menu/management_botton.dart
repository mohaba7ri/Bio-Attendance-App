import 'package:flutter/material.dart';
import 'package:presence/app/model/menu_model.dart';

import '../../util/dinmensions.dart';

class MenuButton extends StatelessWidget {
  final MenuModel menu;
  MenuButton({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    double _size = Dimensions.PADDING_SIZE_DEFAULT;
    return Column(children: [
      Container(
        height: _size - (_size * 0.2),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          color: Colors.green,
          boxShadow: [
            BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 5)
          ],
        ),
        alignment: Alignment.center,
        child: Image.asset(menu.icon,
            width: _size, height: _size, color: Colors.white),
      ),
      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      Text(menu.title,
          //  style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
          textAlign: TextAlign.center),
    ]);
  }
}
