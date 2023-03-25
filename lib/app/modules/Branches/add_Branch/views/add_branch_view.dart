import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';
import '../../../../util/styles.dart';
import '../../../../widgets/custom_input.dart';
import '../controllers/add_branch_controller.dart';

class AddBranchView extends GetView<AddBranchController> {
  AddBranchController _addController = AddBranchController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add_Branch'.tr,
          style: robotoMedium,
        ),
        leading: backButton,
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
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: controller.isLoadingPosition.value == true
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              GetBuilder<AddBranchController>(
                                builder: (_controller) => Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Text('admin_branch'.tr),
                                      ),
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
                                                60 /
                                                100,
                                            child: DropdownButtonHideUnderline(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: DropdownButton2(
                                                  hint: Text('Please Select'),
                                                  items: _controller.userList,
                                                  value: _controller.userName,
                                                  onChanged:
                                                      (String? selectedValue) {
                                                    _controller.changeUserValue(
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
                              ),
                              Obx(
                                () => Column(
                                  children: [
                                    CustomInput(
                                      controller: controller.nameC.value,
                                      label: 'Branch_Name'.tr,
                                      hint: 'Code Tech',
                                      valdate: (value) {
                                        if (value!.isEmpty) {
                                          return 'please enter the branch name';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CustomInput(
                                      controller: controller.phoneC.value,
                                      label: 'Phone'.tr,
                                      hint: '77777777',
                                      valdate: (value) {
                                        if (value!.isEmpty) {
                                          return 'please enter the Phone Number';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CustomInput(
                                      controller: controller.AddressC.value,
                                      label: 'address'.tr,
                                      hint: 'address',
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 200,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.brown.shade300)),
                                        child: Column(
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5)),
                                            Center(
                                                child: Text(
                                              'Set_Branch_Location'.tr,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                          child: CustomInput(
                                                            controller:
                                                                controller
                                                                    .latitudeC
                                                                    .value,
                                                            label:
                                                                'Latitude'.tr,
                                                            hint: '4.35424',
                                                            disabled: true,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                          child: CustomInput(
                                                            controller:
                                                                controller
                                                                    .longitudeC
                                                                    .value,
                                                            label:
                                                                'Longitude'.tr,
                                                            hint: '4.35424',
                                                            disabled: true,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: controller
                                                          .launchOfficeOnMap,
                                                      child: Container(
                                                        height: 84,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColor
                                                              .primaryExtraSoft,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                'assets/images/map.JPG'),
                                                            fit: BoxFit.cover,
                                                            opacity: 0.3,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          'Open_in_maps'.tr,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Obx(
                                () => Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (controller.isLoading.isFalse) {
                                          await controller.create();
                                        }
                                      }
                                    },
                                    child: Text(
                                      (controller.isLoading.isFalse)
                                          ? 'Add'.tr
                                          : 'Loading'.tr,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 18),
                                      backgroundColor: AppColor.primary,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
