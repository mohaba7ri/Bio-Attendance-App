import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:presence/app/controllers/presence_controller.dart';

import '../../../../../company_data.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/toast/custom_toast.dart';

class CompanySignUpController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    determineCompanyPosition();
  }

  final presenceController = Get.find<PresenceController>();
  RxBool isLoading = false.obs;
  RxBool isLoadingPosition = false.obs;
  final nameController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final latitudeController = TextEditingController().obs;
  final longitudeController = TextEditingController().obs;
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

  determineCompanyPosition() async {
    // isLoadingPosition.value = true;
    Map<String, dynamic> _determinePosition =
        await presenceController.determinePosition();
    if (!_determinePosition['error']) {
      Position position = _determinePosition['position'];
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude)
              .whenComplete(() {
        latitudeController.value =
            TextEditingController(text: position.latitude.toString());
        longitudeController.value =
            TextEditingController(text: position.longitude.toString());
        isLoadingPosition.value = false;
        print('the latitude:${latitudeController.value.text}');
      });
      String address =
          "${placemarks.first.street}, ${placemarks.first.subLocality}, ${placemarks.first.locality}";
      addressController.value.text = address;
    }
  }

  Future<void> storePosition(Position position, String address) async {
    //  String uid = auth.currentUser!.uid;
    await company.doc().set({
      "position": {
        "latitude": position.latitude,
        "longitude": position.longitude,
      },
      "address": address,
    });
  }

  Future<void> signUp() async {
    if (nameController.value.text.isNotEmpty &&
        phoneController.value.text.isNotEmpty &&
        addressController.value.text.isNotEmpty &&
        latitudeController.value.text.isNotEmpty &&
        longitudeController.value.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await company.doc().set({
          'name': nameController.value.text,
          'phone': phoneController.value.text,
          'address': addressController.value.text,
          'position': {
            ' latitude': latitudeController.value.text,
            'longitude': longitudeController.value.text,
          },
        });

        Get.toNamed(Routes.LOGIN);
      } catch (e) {
        print('error');
      }
    } else {
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
