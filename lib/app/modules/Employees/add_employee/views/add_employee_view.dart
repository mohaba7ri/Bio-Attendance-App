import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:presence/app/style/app_color.dart';
import 'package:presence/app/widgets/custom_input.dart';

import '../controllers/add_employee_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AddEmployeeView extends GetView<AddEmployeeController> {
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
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(15),
        children: [
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(' Role:'),
                    SizedBox(
                      //  height: MediaQuery.of(context).size.height * 50,
                      width: MediaQuery.of(context).size.width * 40 / 100,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          value: employeeController.roleValue!.value,
                          buttonHeight: 40,
                          buttonWidth: 140,
                          itemHeight: 40,
                          items: employeeController.roleList
                              .map(
                                (roleValue) => DropdownMenuItem(
                                  child: Text(roleValue),
                                  value: roleValue,
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            employeeController.changeRoleValue(value);
                          },
                          //  value: controller.roleValue!.value,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(' Branch:'),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColor.greyColor,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SizedBox(
                          //  height: MediaQuery.of(context).size.height * 50,
                          width: MediaQuery.of(context).size.width * 40 / 100,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              value: employeeController.roleValue!.value,
                              buttonHeight: 40,
                              buttonWidth: 140,
                              itemHeight: 40,
                              items: employeeController.roleList
                                  .map(
                                    (roleValue) => DropdownMenuItem(
                                      child: Text(roleValue),
                                      value: roleValue,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                employeeController.changeRoleValue(value);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          CustomInput(
            controller: controller.idC,
            label: 'Employee ID',
            hint: '1000000001',
          ),
          CustomInput(
            controller: controller.nameC,
            label: 'Full Name',
            hint: 'Johnn Doe',
          ),
          CustomInput(
            controller: controller.emailC,
            label: 'Email',
            hint: 'youremail@email.com',
          ),
          CustomInput(
            controller: controller.jobC,
            label: 'Job',
            hint: 'Employee Job',
          ),
          CustomInput(
            controller: controller.addressC,
            label: 'Address',
            hint: 'hail street',
          ),
          SizedBox(height: 8),
          Container(
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
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => ElevatedButton(
                onPressed: () {
                  controller.changeid();

                  if (controller.isLoading.isFalse) {
                    controller.addEmployee();
                  }
                  if (employeeController.isSelectedPolicy == true) {
                    print('userID' + employeeController.store.read('userID'));
                  }
                },
                child: Text(
                  (controller.isLoading.isFalse)
                      ? 'Add Employee'
                      : 'Loading...',
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
            ),
          )
        ],
      ),
    );
  }
}
