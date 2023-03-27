import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';
import '../../../../util/styles.dart';
import '../../../../widgets/custom_input.dart';
import '../../general_settings/view/branch_setting_view.dart';
import '../controllers/update_branch_controller.dart';

class UpdateBranchView extends GetView<UpdateBranchController> {
  UpdateBranchController _updateController = UpdateBranchController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Update_Branch'.tr,
            style: TextStyle(
              color: AppColor.secondary,
              fontSize: 14,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(Routes.HOME);
              },
              icon: Icon(Icons.home),
              color: AppColor.blackColor,
            )
          ],
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
                                  'Edit_Branch_Information'.tr,
                                  style: TextStyle(fontSize: 20),
                                )),
                            Obx(
                              () => Column(
                                children: [
                                  CustomInput(
                                    controller: controller.nameC.value,
                                    label: 'Branch_Name'.tr,
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
                                          Center(
                                              child: Text(
                                                  'Set_Branch_Location'.tr)),
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
                                                          controller: controller
                                                              .latitudeC.value,
                                                          label: 'Latitude'.tr,
                                                          hint: '',
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
                                                          controller: controller
                                                              .longitudeC.value,
                                                          label: 'Longitude'.tr,
                                                          hint: '',
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
                                                      decoration: BoxDecoration(
                                                        color: AppColor
                                                            .primaryExtraSoft,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        image: DecorationImage(
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
                                        ? 'edit'.tr
                                        : 'Loading'.tr,
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text("General_Settings".tr,
                                      style: robotoHuge)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.brown.shade300)),
                                child: StreamBuilder(
                                  stream: controller.getBranchSettings(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                          child:
                                              Text('Something_went_wrong'.tr));
                                    }

                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(child: Text("Loading".tr));
                                    }

                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 150,
                                        child: ListView(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            physics: BouncingScrollPhysics(),
                                            children: snapshot.data!.docs.map(
                                                (DocumentSnapshot document) {
                                              Map<String, dynamic> data =
                                                  document.data()!
                                                      as Map<String, dynamic>;
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                    elevation: 4,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons
                                                                .more_time_outlined,
                                                            size: 60,
                                                            color: AppColor
                                                                .primary,
                                                          ),
                                                          Text(
                                                            'Start_Time'.tr,
                                                            style: robotoMedium,
                                                          ),
                                                          Text(
                                                            "${DateFormat.jm().format(DateTime.parse(data["startTime"]))}",
                                                            style: robotoMedium,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                    elevation: 4,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons
                                                                .av_timer_rounded,
                                                            size: 60,
                                                            color: AppColor
                                                                .primary,
                                                          ),
                                                          Text(
                                                            'End_Time'.tr,
                                                            style: robotoMedium,
                                                          ),
                                                          Text(
                                                            '${DateFormat.jm().format(DateTime.parse(data["endTime"]))}'
                                                                .tr,
                                                            style: robotoMedium,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                    elevation: 4,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons
                                                                .share_arrival_time_outlined,
                                                            size: 60,
                                                            color: AppColor
                                                                .primary,
                                                          ),
                                                          Text(
                                                            'Late_Time'.tr,
                                                            style: robotoMedium,
                                                          ),
                                                          Text(
                                                            '${DateFormat.jm().format(DateTime.parse(data["lateTime"]))}'
                                                                .tr,
                                                            style: robotoMedium,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                    elevation: 4,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons
                                                                .more_time_outlined,
                                                            size: 60,
                                                            color: AppColor
                                                                .primary,
                                                          ),
                                                          Text(
                                                            'Overly_Time'.tr,
                                                            style: robotoMedium,
                                                          ),
                                                          Text(
                                                            '${DateFormat.jm().format(DateTime.parse(data["overlyTime"]))}'
                                                                .tr,
                                                            style: robotoMedium,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                ],
                                              );
                                            }).toList()));

                                    //SizedBox();
                                  },
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 80,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => BranchSettingView(
                                              branchId: controller
                                                  .branchId['branchId'],
                                            ));
                                  },
                                  child: Text('edit_times'.tr,
                                      style: robotoMediumWhite),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 18),
                                    backgroundColor: AppColor.primary,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
              ),
            ),
          ),
        ));
  }
}
