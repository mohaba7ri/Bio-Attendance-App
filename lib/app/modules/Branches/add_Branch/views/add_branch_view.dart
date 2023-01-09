import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:presence/app/style/app_color.dart';
import 'package:presence/app/widgets/custom_input.dart';

import '../controllers/add_branch_controller.dart';

class AddBranchView extends GetView<AddBranchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Branch',
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
        padding: EdgeInsets.all(20),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomInput(
              controller: controller.idC,
              label: 'Branch ID',
              hint: '1000000001',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomInput(
              controller: controller.nameC,
              label: 'Branch Name',
              hint: 'Sanaa Branch',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomInput(
              controller: controller.AddressC,
              label: 'Address',
              hint: 'Address',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomInput(
              controller: controller.latitudeC,
              label: 'latitude',
              hint: 'latitude',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomInput(
              controller: controller.longitudeC,
              label: 'longitude',
              hint: 'longitude',
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.addEmployee();
                  }
                },
                child: Text(
                  (controller.isLoading.isFalse) ? 'Add Branch' : 'Loading...',
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
