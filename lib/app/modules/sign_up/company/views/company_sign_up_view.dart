import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/modules/profile/views/profile.dart';
import 'package:presence/app/modules/sign_up/company/controlles/company_sing_up_controller.dart';

import '../../../../style/app_color.dart';

class CompanySignUpView extends GetView<CompanySignUpController> {
  CompanySignUpController _signUpController = CompanySignUpController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 100),
                      child: Text('Sing Up'),
                    ),
                    SizedBox(
                        height: 40, child: Text('Enter Company Information')),
                    Column(
                      children: [
                        TextFormField(
                          onChanged: ((value) {
                            _signUpController.name = value;
                          }),
                          decoration: _signUpController.textDecoration.copyWith(
                              hintText: 'Company Name',
                              labelText: 'Company Name'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter  a company name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          onChanged: ((value) {
                            _signUpController.phone = value;
                          }),
                          decoration: _signUpController.textDecoration.copyWith(
                              hintText: 'Phone Number',
                              labelText: 'Phone Number'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter  a Phone Number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          onChanged: ((value) {
                            _signUpController.address = value;
                          }),
                          decoration: _signUpController.textDecoration.copyWith(
                              hintText: 'Address', labelText: 'Address'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter  an address';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.brown.shade300)),
                            child: Column(
                              children: [
                                Center(child: Text('Set Company Location ')),
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: TextFormField(
                                                onChanged: ((value) {
                                                  _signUpController.latitude =
                                                      value;
                                                }),
                                                decoration: _signUpController
                                                    .textDecoration
                                                    .copyWith(
                                                        hintText: 'Latitude',
                                                        labelText: 'Latitude'),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'please enter latitude';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: TextFormField(
                                                onChanged: ((value) {
                                                  _signUpController.longitude =
                                                      value;
                                                }),
                                                decoration: _signUpController
                                                    .textDecoration
                                                    .copyWith(
                                                        hintText: 'Longitude',
                                                        labelText: 'Longitude'),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'please enter longitude';
                                                  }
                                                  return null;
                                                },
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
                                          onTap: controller.launchOfficeOnMap,
                                          child: Container(
                                            height: 84,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: AppColor.primaryExtraSoft,
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                                                  fontWeight: FontWeight.w600),
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
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: SizedBox(
                    //         width: MediaQuery.of(context).size.width * 0.1,
                    //         child: TextFormField(
                    //           onChanged: ((value) {
                    //             _signUpController.latitude = value;
                    //           }),
                    //           decoration: _signUpController.textDecoration
                    //               .copyWith(
                    //                   hintText: 'Start time',
                    //                   labelText: 'Start time'),
                    //           validator: (value) {
                    //             if (value!.isEmpty) {
                    //               return 'please enter start time';
                    //             }
                    //             return null;
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 5,
                    //     ),
                    //     Expanded(
                    //       child: SizedBox(
                    //         width: MediaQuery.of(context).size.width * 0.1,
                    //         child: TextFormField(
                    //           onChanged: ((value) {
                    //             _signUpController.latitude = value;
                    //           }),
                    //           decoration: _signUpController.textDecoration
                    //               .copyWith(
                    //                   hintText: 'End Time',
                    //                   labelText: 'End Time'),
                    //           validator: (value) {
                    //             if (value!.isEmpty) {
                    //               return 'please enter latitude';
                    //             }
                    //             return null;
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    SizedBox(
                      height: 8,
                    ),
                    Obx(
                      () => Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () async {
                            navigator!.pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => ProfileScreen()),
                                (route) => false);
                            // if (_formKey.currentState!.validate()) {
                            //   if (controller.isLoading.isFalse) {
                            //     await controller.signUp();
                            //     //   print('thename is${name}');
                            //   }
                            // }
                          },
                          child: Text(
                            (controller.isLoading.isFalse)
                                ? 'Sign Up'
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
