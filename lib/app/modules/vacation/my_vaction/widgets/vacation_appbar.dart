import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../style/app_color.dart';
import '../my_vacation_controller/my_vacation_controller.dart';

class MyVacationAppBar extends StatelessWidget with PreferredSizeWidget {
  const MyVacationAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('My Vacation'),
      ),
      backgroundColor: Colors.blueAccent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(Icons.arrow_back_ios),
      ),
      actions: [
        GetBuilder<MyVacationController>(
            builder: (controller) => Padding(
                  padding: const EdgeInsets.only(right: 15, top: 10),
                  child: DropdownButton2(
                    value: controller.requestValue,
                    buttonDecoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(10, 10)),
                        ]),
                    items: controller.requestItems
                        .map((items) => DropdownMenuItem(
                              child: Text(
                                items,
                              ),
                              value: items,
                            ))
                        .toList(),
                    onChanged: (value) => controller.changeRequestValue(value!),
                  ),
                ))
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
