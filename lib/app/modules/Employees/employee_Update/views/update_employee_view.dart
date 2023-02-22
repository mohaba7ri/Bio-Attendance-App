import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:presence/app/style/app_color.dart';
import 'package:presence/app/widgets/custom_input.dart';

import '../../../../routes/app_pages.dart';
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
          IconButton(
            onPressed: () => Get.toNamed(Routes.HOME),
            icon: Icon(Icons.home),
            color: AppColor.blackColor,
          )
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
            label: 'Full_Name'.tr,
            hint: 'Johnn Doe',
          ),
          CustomInput(
            controller: controller.emailC,
            label: 'email'.tr,
            hint: 'youremail@email.com',
          ),
          CustomInput(
            controller: controller.jobC,
            label: 'Job'.tr,
            hint: 'Employee Job',
          ),
          CustomInput(
            controller: controller.addressC,
            label: 'Address'.tr,
            hint: 'hail street',
          ),
          CustomInput(
            controller: controller.phoneC,
            label: 'Phone'.tr,
            hint: '7****',
          ),
          CustomInput(
            keyboardType: TextInputType.number,
            controller: controller.salaryPerHour,
            label: 'salary_per_hour'.tr,
            hint: '1500',
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                // controller.changeid();

                // if (controller.isLoading == false) {
                //   controller.addEmployee();
                // }
                // if (controller.isSelectedPolicy == true) {
                //   print('userID' +
                //       controller.store.read('userID'));
                // }
              },
              child: Text(
                (controller.isLoading == false) ? 'edit'.tr : 'Loading'.tr,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'poppins',
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                padding: EdgeInsets.symmetric(vertical: 18),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
