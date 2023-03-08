import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../../style/app_color.dart';
import '../controllers/add_employee_controller.dart';

class ManagePoliciesView extends GetView<AddEmployeeController> {
  final employeeController = AddEmployeeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Employee',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 14,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: Container(
        height: 200,
        width: MediaQuery.of(context).size.width * 0,
        decoration: BoxDecoration(
            color: AppColor.greyColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(2, 2),
                  blurRadius: 5,
                  spreadRadius: 1)
            ],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.whiteColor, width: 1.5)),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: employeeController.roles.length,
            itemBuilder: (context, int index) {
              final controller = AddEmployeeController();
              controller.rolesValue();
              return Obx(
                () => CheckboxListTile(
                  selectedTileColor: Colors.blue,
                  title: Text(employeeController.roles[index].value),
                  value: controller.selectedPolicyValue![index].value,
                  onChanged: (bool? value) {
                    controller.changePolicyValue(value!, index);
                    employeeController.storePolicyValue(index, value);
                  },
                ),
              );
            }),
      ),
    );
  }
}
