import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:presence/app/widgets/custom_input.dart';

import '../../../../style/app_color.dart';
import '../controllers/update_branch_controller.dart';

class UpdateBranchView extends GetView<UpdateBranchController> {
  UpdateBranchController _updateController = UpdateBranchController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Branch',
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
      backgroundColor: Colors.white,
      body: SafeArea(
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
                          SizedBox(
                              height: 40,
                              child: Text(
                                'Edit Branch Information',
                                style: TextStyle(fontSize: 20),
                              )),
                          Obx(
                            () => Column(
                              children: [
                                CustomInput(
                                  controller: controller.nameC.value,
                                  label: 'Branch Name',
                                  hint: '',

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
                                  label: 'Phone',
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
                                  label: 'address',
                                  hint: 'address',
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 180,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.brown.shade300)),
                                    child: Column(
                                      children: [
                                        Center(
                                            child:
                                                Text('Set Branch Location ')),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                      child: CustomInput(
                                                        controller: controller
                                                            .latitudeC.value,
                                                        label: 'Latitude',
                                                        hint: '4.35424',
                                                        disabled: true,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                      child: CustomInput(
                                                        controller: controller
                                                            .longitudeC.value,
                                                        label: 'Longitude',
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
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: AppColor
                                                          .primaryExtraSoft,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/map.JPG'),
                                                        fit: BoxFit.cover,
                                                        opacity: 0.3,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      'Open in maps',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                      ? 'Add'
                                      : 'Loading...',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 18),
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
    );
  }
}