import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:presence/app/style/app_color.dart';
import 'package:presence/app/util/styles.dart';

import '../manage_vacations_controller/manage_vacations_controller.dart';
import '../widgets/manage_vacation_appbar.dart';

class ManageVacationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColor.greyShade200,
      appBar: MyVacationAppBar(),
      body: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.7,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(15), right: Radius.circular(15)),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.03,
            right: MediaQuery.of(context).size.width * 0.03,
            // bottom: MediaQuery.of(context).size.width * 0.99,
            child: GetBuilder<ManageVacationController>(
              builder: (controller) => Container(
                height: MediaQuery.of(context).size.height * 0.47,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(10, 10)),
                    ]),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 25),
                      child: Column(children: [
                        Row(children: [
                          ClipOval(
                            child: Container(
                              width: 42,
                              height: 42,
                              child: Image.network(
                                // Images.profile
                                (controller.VacList["avatar"] == null ||
                                        controller.VacList['avatar'] == "")
                                    ? "https://ui-avatars.com/api/?name=${controller.VacList['userName']}/"
                                    : controller.VacList['avatar'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ]),
                        Row(
                          children: [
                            Text("Name ", style: robotoMedium),
                            Text(controller.VacList['userName'],
                                style: robotoMedium),
                          ],
                        ),
                        customDivider(),
                        Row(
                          children: [
                            Text("Type ", style: robotoMedium),
                            Text(controller.VacList['vacationType'],
                                style: robotoMedium)
                          ],
                        ),
                        customDivider(),
                        Row(
                          children: [
                            Text("Start Date ", style: robotoMedium),
                            Text(controller.VacList['startDate'],
                                style: robotoMedium)
                          ],
                        ),
                        customDivider(),
                        Row(
                          children: [
                            Text("End Date ", style: robotoMedium),
                            Text(controller.VacList['endDate'],
                                style: robotoMedium)
                          ],
                        ),
                        customDivider(),
                        Row(
                          children: [
                            Text("Days", style: robotoMedium),
                            Text(controller.VacList['days'],
                                style: robotoMedium)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('Decline'.tr),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Colors.red.shade400)),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Accept'.tr),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Colors.teal.shade400)),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.7,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(15), right: Radius.circular(15)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class customDivider extends StatelessWidget {
  const customDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1, // thickness of the line
      indent: 10, // empty space to the leading edge of divider.
      endIndent: 10, // empty space to the trailing edge of the divider.
      color: AppColor.primarySoft, // The color to use when painting the line.
      // The divider's height extent.
    );
  }
}
