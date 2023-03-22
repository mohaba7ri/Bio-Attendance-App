import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/custom_input.dart';
import '../controller/branch_seting_controlleer.dart';

class BranchSettingView extends GetView<BranchSettingController> {
  final branchId;
  BranchSettingView({this.branchId});
  @override
  Widget build(BuildContext context) {
    controller.branchId.value = branchId;
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Dialog(
        child: Obx(
          () => SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Container(
                    width: 38,
                    child: Divider(
                      thickness: .6,
                      color: Color(0xff008BC5),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 5,
                    width: 23,
                    child: Divider(
                      thickness: .6,
                      color: Color(0xff008BC5),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Branch_working_times'.tr,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff008BC5)),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: CustomInput(
                      disabled: true,
                      controller: TextEditingController(
                          text: controller.startTime.value.format(context)),
                      label: 'Start_Time'.tr,
                      hint: '8:00',
                      suffixIcon: IconButton(
                          onPressed: () async {
                            final initialTime = controller.startTime.value;
                            final selectedTime = await controller
                                .showTimePickers(context, initialTime);
                            controller.setStartTime(selectedTime);
                          },
                          icon: Icon(Icons.access_time))),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: CustomInput(
                      disabled: true,
                      controller: TextEditingController(
                          text: controller.lateTime.value.format(context)),
                      label: 'Late_Time'.tr,
                      hint: '8:30',
                      suffixIcon: IconButton(
                          onPressed: () async {
                            final initialTime = controller.startTime.value;
                            final selectedTime = await controller
                                .showTimePickers(context, initialTime);
                            controller.lateTime(selectedTime);
                          },
                          icon: Icon(Icons.access_time))),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: CustomInput(
                      disabled: true,
                      controller: TextEditingController(
                          text: controller.endTime.value.format(context)),
                      label: 'End_Time'.tr,
                      hint: '2:00',
                      suffixIcon: IconButton(
                          onPressed: () async {
                            final initialTime = controller.startTime.value;
                            final selectedTime = await controller
                                .showTimePickers(context, initialTime);
                            controller.endTime(selectedTime);
                          },
                          icon: Icon(Icons.access_time))),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: CustomInput(
                      disabled: true,
                      controller: TextEditingController(
                          text: controller.overlyTime.value.format(context)),
                      label: 'Overly_Time'.tr,
                      hint: '2:30',
                      suffixIcon: IconButton(
                          onPressed: () async {
                            final initialTime = controller.startTime.value;
                            final selectedTime = await controller
                                .showTimePickers(context, initialTime);
                            controller.overlyTime(selectedTime);
                          },
                          icon: Icon(Icons.access_time))),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: MaterialButton(
                    color: Colors.blueAccent.shade400,
                    onPressed: () {
                      controller.storeBranchSetting();
                      Get.back();
                    },
                    child: Text('Save'.tr),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
