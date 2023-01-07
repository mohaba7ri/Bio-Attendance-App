import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../../../../company_data.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/toast/custom_toast.dart';

class CompanySignUpController extends GetxController {
  RxBool isLoading = false.obs;
  late String name;
  late String phone;
  late String address;
  late String latitude;
  late String longitude;
  CollectionReference company =
      FirebaseFirestore.instance.collection('company');
  launchOfficeOnMap() {
    try {
      MapsLauncher.launchCoordinates(
        CompanyData.office['latitude'],
        CompanyData.office['longitude'],
      );
    } catch (e) {
      CustomToast.errorToast('Error', 'Error : ${e}');
    }
  }

  Future<void> signUp() async {
    if (name.isNotEmpty &&
        phone.isNotEmpty &&
        address.isNotEmpty &&
        latitude.isNotEmpty &&
        longitude.isNotEmpty) {
      isLoading.value = true;
      try {
        await company.doc(name).set({
          'name': name,
          'phone': phone,
          'address': address,
          'latitude': latitude,
          'longitude': longitude,
        });
        print('thename is$name');
        Get.toNamed(Routes.LOGIN);
      } catch (e) {
        print('error');
      }
    } else {
      print('thename is$name');
      CustomToast.errorToast("Error", "You need to fill all fields");
    }
  }

  var textDecoration = InputDecoration(
    labelText: 'Full name',
    hintText: 'Enter your full name',
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(color: Colors.purple, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2),
    ),
  );
}
