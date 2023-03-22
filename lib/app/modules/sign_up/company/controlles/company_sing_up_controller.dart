import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../../../controllers/presence_controller.dart';
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
  final argument = ''.obs;
  var firebase = FirebaseFirestore.instance;
  launchOfficeOnMap() {
    try {
      MapsLauncher.launchCoordinates(
        double.parse(latitudeController.value.text),
        double.parse(longitudeController.value.text),
      );
    } catch (e) {
      CustomToast.errorToast('Error : ${e}');
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
      });
      String address =
          "${placemarks.first.street}, ${placemarks.first.subLocality}, ${placemarks.first.locality}";
      addressController.value.text = address;
    }
  }

  Future<void> storePosition(Position position, String address) async {
    //  String uid = sharedPreferences.getString('userId')!;
    await firebase.collection('company').doc().set({
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
        String docId = const Uuid().v4();
        argument.value = docId;
        await firebase.collection('company').doc(docId).set({
          'name': nameController.value.text,
          'phone': phoneController.value.text,
          'address': addressController.value.text,
          'companyId': docId,
          'position': {
            ' latitude': latitudeController.value.text,
            'longitude': longitudeController.value.text,
          },
        });
        await firebase.collection('branch').doc(docId).set({
          'name': nameController.value.text,
          'phone': phoneController.value.text,
          'address': addressController.value.text,
          'branchId': docId,
          'position': {
            ' latitude': latitudeController.value.text,
            'longitude': longitudeController.value.text,
          },
        });

        //  Get.toNamed(Routes.LOGIN);
      } catch (e) {
        print('error');
      }
    } else {
      CustomToast.errorToast("you_need_to_fill_all_fields".tr);
    }
  }

  var textDecoration = InputDecoration(
    labelText: 'full_name'.tr,
    hintText: '',
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
