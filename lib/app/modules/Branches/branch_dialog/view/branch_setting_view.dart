import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../controller/branch_seting_controlleer.dart';

class BranchOptionsView extends GetView<BranchOptionsController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Dialog(
          child: Column(
        children: [
          Text(
            "Choose you sick fuck",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color(0xff008BC5)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.50,
              child: MaterialButton(
                color: Colors.blueAccent.shade400,
                onPressed: () {
                  Get.toNamed(Routes.Branch_Setting);
                },
                child: Text('General Settings'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.50,
              child: MaterialButton(
                color: Colors.blueAccent.shade400,
                onPressed: () {
                  Get.back();
                },
                child: Text('Edit information'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.50,
              child: MaterialButton(
                color: Color.fromARGB(255, 248, 104, 20),
                onPressed: () {
                  Get.back();
                },
                child: Text('Close'),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
