import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyVacationAppBar extends StatelessWidget with PreferredSizeWidget {
  const MyVacationAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('manage_vacations'.tr),
      ),
      backgroundColor: Colors.blueAccent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(Icons.arrow_back_ios),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
