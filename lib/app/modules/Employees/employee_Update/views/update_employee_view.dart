import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';
import '../../../../widgets/custom_input.dart';
import '../controllers/update_employee_controller.dart';

class UpdateEmployeeView extends GetView<UpdateEmployeeController> {
  //final Map<String, dynamic> user = Get.arguments;

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
      body: GetBuilder<UpdateEmployeeController>(
        builder: (_controller) => ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(20),
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text('Role'.tr),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          //  height: MediaQuery.of(context).size.height * 50,
                          width: MediaQuery.of(context).size.width * 42 / 100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                hint: Text('Please Select'),

                                items: controller.roleList
                                    .map(
                                      (roleValue) => DropdownMenuItem(
                                        child: Text(roleValue),
                                        value: roleValue,
                                      ),
                                    )
                                    .toList(),
                                value: controller.roleValue,
                                onChanged: (value) {
                                  controller.changeRoleValue(value);
                                },
                                //  value: controller.roleValue!.value,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text('branch'.tr),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 5)
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        //  height: MediaQuery.of(context).size.height * 50,
                        width: MediaQuery.of(context).size.width * 45 / 100,
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: DropdownButton2(
                              hint: Text('Please Select'),
                              items: controller.branchesList,
                              value: controller.branchValue,
                              onChanged: (String? selectedValue) {
                                controller.changeBranchValue(selectedValue);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

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

            Row(
              children: [
                Text('Status'),
                Spacer(),
                Switch(
                    value: _controller.isActive,
                    onChanged: (value) {
                      _controller.changeEmpStatus(value);
                    })
              ],
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  controller.updateEmployee();
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
      ),
    );
  }
}
