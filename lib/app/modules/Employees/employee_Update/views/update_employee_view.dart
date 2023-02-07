import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:presence/app/style/app_color.dart';
import 'package:presence/app/widgets/custom_input.dart';

import '../controllers/update_employee_controller.dart';

class UpdateEmployeeView extends GetView<UpdateEmployeeController> {
  //final Map<String, dynamic> user = Get.arguments;

  final controller = Get.put(UpdateEmployeeController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    UpdateEmployeeController _updateEmployeeController =
        UpdateEmployeeController();

    // controller.employeeAddressC.text = controller.EmpDetail['name'];

    ;
    // controller.emailC.text = emp["email"];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit_Employee'.tr,
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 14,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
        actions: [
          Obx(
            () => TextButton(
              onPressed: () {
                // if (controller.isLoading.isFalse) {
                //   controller.updateEmployee();
                // }
              },
              child:
                  Text((controller.isLoading.isFalse) ? 'Done' : 'Loading...'),
              style: TextButton.styleFrom(
                foregroundColor: AppColor.primary,
              ),
            ),
          ),
        ],
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
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(20),
        children: [
          // section 1 - Profile Picture

          //section 2 - user data
          CustomInput(
            controller: controller.nameC,
            label: "Full_Name".tr,
            hint: "Your Full Name",
            margin: EdgeInsets.only(bottom: 16, top: 42),
          ),
          CustomInput(
            controller: controller.employeeAddressC,
            label: "Address".tr,
            hint: "",
            disabled: true,
          ),
          CustomInput(
            controller: controller.emailC,
            label: "email".tr,
            hint: "youremail@email.com",
            disabled: true,
          ),
        ],
      ),
    );
  }
}
