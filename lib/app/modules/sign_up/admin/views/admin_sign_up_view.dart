import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';


import '../../../../style/app_color.dart';
import '../controllers/admin_sing_up_controller.dart';

class AdminSignUpView extends GetView<AdminSignUpController> {
  AdminSignUpController _adminSignUpController = AdminSignUpController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.white,

            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          title: Text('set_admin_information'.tr),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Form(
            key: _formKey,
            child: Column(children: [
              Divider(
                thickness: 2,
              ),
              TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please_enter_your_name'.tr;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _adminSignUpController.name = value;
                  },
                  decoration: _adminSignUpController.textDecoration
                      .copyWith(labelText: 'full_name'.tr, hintText: 'full_name'.tr)),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please_enter_your_phone_number'.tr;
                  }
                  return null;
                },
                onChanged: (value) {
                  _adminSignUpController.phone = value;
                },
                decoration: _adminSignUpController.textDecoration
                    .copyWith(labelText: 'phone_number'.tr, hintText: ''),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please_enter_your_job'.tr;
                  }
                  return null;
                },
                onChanged: (value) {
                  _adminSignUpController.job = value;
                },
                decoration: _adminSignUpController.textDecoration
                    .copyWith(labelText: 'job'.tr, hintText: ''),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value) {
                  _adminSignUpController.email = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please_enter_your_email'.tr;
                  }
                  return null;
                },
                decoration: _adminSignUpController.textDecoration.copyWith(
                    labelText: 'Email_address'.tr, hintText: 'example@gmail.com'),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value) {
                  _adminSignUpController.password = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please_enter_your_password'.tr;
                  }
                  return null;
                },
                decoration: _adminSignUpController.textDecoration
                    .copyWith(labelText: 'password'.tr, hintText: ''),
              ),
              Obx(
                () => Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (controller.isLoading.isFalse) {
                          _adminSignUpController.signUp();
                        }
                      }
                    },
                    child: Text(
                      (controller.isLoading.isFalse) ? 'Log_in'.tr : 'Loading'.tr,
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
    );
  }
}
