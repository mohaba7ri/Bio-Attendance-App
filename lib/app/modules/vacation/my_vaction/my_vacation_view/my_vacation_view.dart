import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:presence/app/modules/vacation/my_vaction/my_vacation_controller/my_vacation_controller.dart';
import 'package:presence/app/style/app_color.dart';

class MyVacationView extends GetView<MyVacationController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColor.greyShade200,
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 600,
            child: Container(
              height: 400,
              width: MediaQuery.of(context).size.width * 100 / 100,
              decoration: BoxDecoration(color: Colors.blueAccent),
            ),
          ),
          Expanded(
            child: Positioned(
              top: 150,
              left: 10,
              right: 10,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width * 100 / 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(10, 10)),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
