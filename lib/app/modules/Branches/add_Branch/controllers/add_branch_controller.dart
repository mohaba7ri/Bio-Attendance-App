import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../../../controllers/presence_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/toast/custom_toast.dart';
import 'package:uuid/uuid.dart';

class AddBranchController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    determineBranchPosition();
    await getUser();
  }

  final presenceController = Get.find();
  RxBool isLoading = false.obs;
  RxBool isLoadingPosition = false.obs;
  final nameC = TextEditingController().obs;
  final phoneC = TextEditingController().obs;
  final AddressC = TextEditingController().obs;
  final latitudeC = TextEditingController().obs;
  final longitudeC = TextEditingController().obs;
  final userList = <DropdownMenuItem<String>>[].obs;
  String userId = '';
  String? userName;

  final fireStore = FirebaseFirestore.instance;

  launchOfficeOnMap() {
    try {
      MapsLauncher.launchCoordinates(
        double.parse(latitudeC.value.text),
        double.parse(longitudeC.value.text),
      );
    } catch (e) {
      CustomToast.errorToast('Error : ${e}');
    }
  }

  Future getUser() async {
    try {
      await fireStore
          .collection('user')
          .where('role', isEqualTo: 'Admin')
          .get()
          .then((query) {
        query.docs.forEach((query) {
          Map<String, dynamic> data = query.data();
          userList.add(DropdownMenuItem(
            child: Text(data['name']),
            value: data['name'],
          ));
          userId = data['userId'];
          update();
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateUser(branchId) async {
    await fireStore
        .collection('user')
        .doc(userId)
        .update({'branchId': branchId});
  }

  changeUserValue(value) async {
    userName = value;
    update();
    await fireStore
        .collection('user')
        .where('name', isEqualTo: userName)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data();
        userId = data['userId'];
        print('the userId$userId');
        update();
      });
    });
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

  Future<void> create() async {
    if (nameC.value.text.isNotEmpty &&
        phoneC.value.text.isNotEmpty &&
        AddressC.value.text.isNotEmpty &&
        latitudeC.value.text.isNotEmpty &&
        longitudeC.value.text.isNotEmpty) {
      isLoading.value = true;
      try {
        String branchId = const Uuid().v4();
        await fireStore.collection('branch').doc(branchId).set({
          'name': nameC.value.text,
          'phone': phoneC.value.text,
          'address': AddressC.value.text,
          'branchAdminId': userId,
          'branchAdmin': userName,
          'branchId': branchId,
          'position': {
            ' latitude': latitudeC.value.text,
            'longitude': longitudeC.value.text,
          },
        });
        await updateUser(branchId);
        CustomToast.successToast("Added branch successfully");
        Get.toNamed(Routes.LIST_BRANCH);
      } catch (e) {
        print('error');
      }
    } else {
      CustomToast.errorToast("You need to fill all fields");
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
