import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/util/styles.dart';
import 'package:presence/app/widgets/custom_input.dart';

import '../../../../style/app_color.dart';
import '../controllers/update_company_controller.dart';

class UpdateCompanyView extends GetView<UpdateCompanyController> {
  UpdateCompanyController _updateCompanyController = UpdateCompanyController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String companyId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Update Company',
            style: robotoMedium,
          ),
          leading: backButton,
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
                                Obx(
                                  () => Column(
                                    children: [
                                      CustomInput(
                                        controller: controller.nameC.value,
                                        label: 'Company Name',
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
                                        label: 'Address',
                                        hint: 'Address',
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      CustomInput(
                                        controller: controller.EmailC.value,
                                        label: 'Email',
                                        hint: 'Email',
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
                                                  color:
                                                      Colors.brown.shade300)),
                                          child: Column(
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5)),
                                              Center(
                                                  child: Text(
                                                'Set Company Location ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                              label: 'Latitude',
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
                                                                  'Longitude',
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
                                                                    .circular(
                                                                        8),
                                                            image:
                                                                DecorationImage(
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
                                            ? 'Add'
                                            : 'Loading...',
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
                                          borderRadius:
                                              BorderRadius.circular(8),
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
        ));
  }
}
