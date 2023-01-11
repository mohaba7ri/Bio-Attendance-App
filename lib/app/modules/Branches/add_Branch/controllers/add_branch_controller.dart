import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:presence/app/controllers/presence_controller.dart';

import '../../../../../branch_data.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/toast/custom_toast.dart';

class AddBranchController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    determineBranchPosition();
  }

  final presenceController = Get.find<PresenceController>();
  RxBool isLoading = false.obs;
  RxBool isLoadingPosition = false.obs;
  final nameC = TextEditingController().obs;
  final phoneC = TextEditingController().obs;
  final AddressC = TextEditingController().obs;
  final latitudeC = TextEditingController().obs;
  final longitudeC = TextEditingController().obs;

  CollectionReference branch = FirebaseFirestore.instance.collection('branch');
  launchOfficeOnMap() {
    try {
      MapsLauncher.launchCoordinates(
        BranchData.office['latitude'],
        BranchData.office['longitude'],
      );
    } catch (e) {
      CustomToast.errorToast('Error', 'Error : ${e}');
    }
  }

  determineBranchPosition() async {
    // isLoadingPosition.value = true;
    Map<String, dynamic> _determinePosition =
        await presenceController.determinePosition();
    if (!_determinePosition['error']) {
      Position position = _determinePosition['position'];
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude)
              .whenComplete(() {
        latitudeC.value =
            TextEditingController(text: position.latitude.toString());
        longitudeC.value =
            TextEditingController(text: position.longitude.toString());
        isLoadingPosition.value = false;
      });
      String address =
          "${placemarks.first.street}, ${placemarks.first.subLocality}, ${placemarks.first.locality}";
      AddressC.value.text = address;
    }
  }

  Future<void> storePosition(Position position, String address) async {
    //  String uid = auth.currentUser!.uid;
    await branch.doc().set({
      "position": {
        "latitude": position.latitude,
        "longitude": position.longitude,
      },
      "address": address,
    });
  }

  Future<void> create() async {
    if (nameC.value.text.isNotEmpty &&
        phoneC.value.text.isNotEmpty &&
        AddressC.value.text.isNotEmpty &&
        latitudeC.value.text.isNotEmpty &&
        longitudeC.value.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await branch.doc().set({
          'name': nameC.value.text,
          'phone': phoneC.value.text,
          'address': AddressC.value.text,
          'position': {
            ' latitude': latitudeC.value.text,
            'longitude': longitudeC.value.text,
          },
        });
        CustomToast.successToast("Success", "Added branch successfully");
        Get.toNamed(Routes.profile);
      } catch (e) {
        print('error');
      }
    } else {
      CustomToast.errorToast("Error", "You need to fill all fields");
    }
  }

  var textDecoration = InputDecoration(
    labelText: 'Full name',
    hintText: 'Enter branch name',
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
