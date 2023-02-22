import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence/app/style/app_color.dart';
import 'package:presence/app/widgets/custom_input.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/add_employee_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AddEmployeeView extends StatelessWidget {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add_Employee'.tr,
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 14,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.blackColor,
          ),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.grey[200],
            child: GetBuilder<AddEmployeeController>(
              builder: (controller) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ],
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.all(15),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Text('Role'.tr),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 5)
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: SizedBox(
                                            //  height: MediaQuery.of(context).size.height * 50,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                42 /
                                                100,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton2(
                                                  value: controller.roleValue,
                                                  buttonHeight: 50,
                                                  buttonWidth: 40,
                                                  itemHeight: 40,
                                                  items: controller.roleList
                                                      .map(
                                                        (roleValue) =>
                                                            DropdownMenuItem(
                                                          child:
                                                              Text(roleValue),
                                                          value: roleValue,
                                                        ),
                                                      )
                                                      .toList(),
                                                  onChanged: (value) {
                                                    controller
                                                        .changeRoleValue(value);
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
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 5)
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: SizedBox(
                                          //  height: MediaQuery.of(context).size.height * 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              45 /
                                              100,
                                          child: DropdownButtonHideUnderline(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: DropdownButton2(
                                                buttonHeight: 50,
                                                buttonWidth: 40,
                                                itemHeight: 40,
                                                value: controller.branchValue,
                                                items: controller.branchesList,
                                                onChanged:
                                                    (String? selectedValue) {
                                                  controller.changeBranchValue(
                                                      selectedValue);
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
                            ],
                          ),
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
                                controller.changeid();

                                if (controller.isLoading == false) {
                                  controller.addEmployee();
                                }
                                if (controller.isSelectedPolicy == true) {
                                  print('userID' +
                                      controller.store.read('userID'));
                                }
                              },
                              child: Text(
                                (controller.isLoading == false)
                                    ? 'Add'.tr
                                    : 'Loading'.tr,
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
