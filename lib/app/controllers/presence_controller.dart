import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/dialog/custom_alert_dialog.dart';
import '../widgets/toast/custom_toast.dart';

class PresenceController extends GetxController {
  RxBool isLoading = false.obs;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? lateTime;
  DateTime? overlyTime;
  DateTime? currentTime = DateTime.now();
  String? timeStatus;
  String? hoursWork;
  RxString companyId = ''.obs;
  RxString branchId = ''.obs;
  final SharedPreferences sharedPreferences;
  RxMap office = {}.obs;
  PresenceController({required this.sharedPreferences});
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    // await getCompany();
    await getBranch();
    await getCompanySetting();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    print('the current Time$currentTime');
  }

  checkTime() async {
    currentTime = DateTime.now();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Future getCompany() async {
  //   try {
  //     await firestore.collection('company').get().then((query) {
  //       query.docs.forEach((doc) {
  //         Map<String, dynamic> data = doc.data();
  //         companyId.value = data['companyId'];
  //         // print('the companyId${companyId.value}');
  //         // if (data["position"][" latitude"] != null &&
  //         //     data["position"]["longitude"] != null) {
  //         //   print('the latitude${data["position"][" latitude"]}');
  //         //   office["latitude"] = double.parse(data["position"][" latitude"]);
  //         //   office["longitude"] = double.parse(data["position"]["longitude"]);
  //         //   print(office["longitude"]);
  //         // } else {
  //         //   print('true');
  //         // }
  //       });
  //     });
  //   } catch (e) {}
  // }

  Future getBranch() async {
    await firestore
        .collection('user')
        .doc(sharedPreferences.getString('userId')!)
        .get()
        .then((data) {
      branchId.value = data['branchId'];
    });
    firestore.collection('branch').doc(branchId.value).get().then((data) {
      if (data["position"][" latitude"] != null &&
          data["position"]["longitude"] != null) {
        print('the latitude${data["position"][" latitude"]}');
        office["latitude"] = double.parse(data["position"][" latitude"]);
        office["longitude"] = double.parse(data["position"]["longitude"]);
        print(office["longitude"]);
      } else {
        print('true');
      }
    });
  }

  Future getCompanySetting() async {
    try {
      await firestore
          .collection('branchSettings')
          .where('branchId', isEqualTo: branchId.value)
          .get()
          .then((QuerySnapshot query) {
        query.docs.forEach((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          startTime = DateTime.parse(data['startTime']);
          endTime = DateTime.parse(data['endTime']);
          lateTime = DateTime.parse(data['lateTime']);
          overlyTime = DateTime.parse(data['overlyTime']);
        });
      });
    } catch (e) {}
  }

  Future getAddress() async {
    Map<String, dynamic> _determinePosition = await determinePosition();
    if (!_determinePosition["error"]) {
      Position position = _determinePosition["position"];
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      String address =
          "${placemarks.first.street}, ${placemarks.first.subLocality}, ${placemarks.first.locality},${placemarks.first.name}";
    } else {
      Get.snackbar("there_is_an_error".tr, _determinePosition["message"]);
      print(_determinePosition["error"]);
    }
  }

  presence() async {
    isLoading.value = true;

    Map<String, dynamic> _determinePosition = await determinePosition();
    if (!_determinePosition["error"]) {
      Position position = _determinePosition["position"];
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      String address =
          "${placemarks.first.street}, ${placemarks.first.subLocality}, ${placemarks.first.locality},${placemarks.first.name}";
      double distance = Geolocator.distanceBetween(office['latitude'],
          office['longitude'], position.latitude, position.longitude);
      //get the company Settings
      await getCompanySetting();
      // update position ( store to database )
      await updatePosition(position, address);
      // presence ( store to database )
      await processPresence(position, address, distance);
      isLoading.value = false;
    } else {
      isLoading.value = false;
      Get.snackbar("there_is_an_error".tr, _determinePosition["message"]);
      print(_determinePosition["error"]);
    }
  }

  Future<bool> checkVacationStatus(String userId) async {
    final vacatioRequest = FirebaseFirestore.instance
        .collection('vacationRequest')
        .where('userId', isEqualTo: userId);
    final vacationSnapshot = await vacatioRequest.get();
    final documents = vacationSnapshot.docs;
    for (var doc in documents) {
      var status = doc.data()['status'];
      var startDate = DateFormat("MMM dd, yyyy").parse(doc.data()['startDate']);
      var endDate = DateFormat("MMM dd, yyyy").parse(doc.data()['endDate']);
      print('thesartDate$startDate');
      var currentTime = DateTime.now();
      if (status == 'Approved' &&
          currentTime.isAfter(startDate) &&
          currentTime.isBefore(endDate)) {
        print('satus$status');
        return false;
      }
    }

    return true;
  }

  firstPresence(
    CollectionReference<Map<String, dynamic>> presenceCollection,
    String todayDocId,
    Position position,
    String address,
    double distance,
    bool in_area,
  ) async {
    bool allowCheckIn =
        await checkVacationStatus(sharedPreferences.getString('userId')!);
    if (allowCheckIn) {
      if (in_area != true) {
        print('the in area$in_area');
        CustomToast.errorToast('you_cannot_check_in_you_are_out_area'.tr);
      } else {
        CustomAlertDialog.showPresenceAlert(
          title: "do_you_want_to_check_in?".tr,
          message: "you_need_to_confirm_before_you_can_do_presence_now".tr,
          onCancel: () => Get.back(),
          onConfirm: () async {
            await presenceCollection.doc(todayDocId).set(
              {
                "date": DateTime.now().toIso8601String(),
                "status": 'Present',
                "timing": 'On Time',
                "checkIn": {
                  "status": timeStatus,
                  "date": DateTime.now().toIso8601String(),
                  "latitude": position.latitude,
                  "longitude": position.longitude,
                  "address": address,
                  "in_area": in_area,
                  "distance": distance,
                }
              },
            );
            Get.back();
            CustomToast.successToast("success_check_in".tr);
          },
        );
      }
    } else {
      CustomAlertDialog.showPresenceAlert(
          title: 'vacations'.tr,
          message:
              'sorry_you_cant_check_in_because_you_have_vacation_do_you_want_to_cancel_vacation_request'
                  .tr,
          onConfirm: () {},
          onCancel: () => Get.back());
    }
  }

  Future<bool> calCheckIn() async {
    bool chechIn;
    int currentHour = currentTime!.hour * 60 + currentTime!.minute;
    int startHour = startTime!.hour * 60 + startTime!.minute;
    int lateHour = lateTime!.hour * 60 + lateTime!.minute;
    int endHour = endTime!.hour * 60 + endTime!.minute;
    int overlyHoure = overlyTime!.hour * 60 + overlyTime!.minute;
    if (currentHour < startHour) {
      print("Check-in time has not arrived yet.");
      CustomToast.errorToast('check-in_time_has_not_arrived_yet'.tr);
      return chechIn = false;
    } else if (currentHour > startHour && currentHour <= lateHour) {
      print("Check-in is on time.");

      print(currentHour);
      update();
      print('lateHour$lateHour');
      return chechIn = true;
    } else {
      print("Check-in is late.");
      int lateMinutes = (currentHour - lateHour);
      int lateHours = lateMinutes ~/ 60;
      int lateMinutesRemainder = lateMinutes % 60;
      print(currentTime);
      print('lateHour$lateMinutes');

      Get.snackbar(
          'Late'.tr,
          'You_are_being_late_for'.tr +
              '${lateHours}:${lateMinutesRemainder}' +
              'minutes'.tr);
      return chechIn = true;
    }
  }

  Future<bool> calCheckOut() async {
    bool chechOut;
    int currentHour = currentTime!.hour * 60 + currentTime!.minute;
    int startHour = startTime!.hour * 60 + startTime!.minute;
    int lateHour = lateTime!.hour * 60 + lateTime!.minute;
    int endHour = endTime!.hour * 60 + endTime!.minute;
    int overlyHoure = overlyTime!.hour * 60 + overlyTime!.minute;
    if (currentHour < endHour) {
      print("Check-out time has not arrived yet.");
      CustomToast.errorToast('check-out_time_has_not_arrived_yet'.tr);
      return chechOut = false;
    } else {
      print("Check-out time has passed.");
      return chechOut = true;
    }
  }

  calHoursWork() async {
    String? durationString;
    final userId = sharedPreferences.getString('userId')!;
    String todayDocId =
        DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");
    try {
      await firestore
          .collection('user')
          .doc(userId)
          .collection('presence')
          .doc(todayDocId)
          .get()
          .then((data) {
        String startTimeStr = data['checkIn']['date'];

        DateTime startTime = DateTime.parse(startTimeStr);
        DateTime endTime = DateTime.now();

        Duration difference = endTime.difference(startTime);

        int hours = difference.inHours;

        int minutes = difference.inMinutes.remainder(60);

        print('Hours: $hours, Minutes: $minutes');

        print('chechIn${data['checkIn']['date']}');
        durationString = '$hours:${minutes.toString().padLeft(2, '0')}';

        print('Duration: $durationString');
        hoursWork = durationString;
        update();
      });
    } catch (e) {}
  }

  checkinPresence(
    CollectionReference<Map<String, dynamic>> presenceCollection,
    String todayDocId,
    Position position,
    String address,
    double distance,
    bool in_area,
  ) async {
    update();

    bool allowCheckIn =
        await checkVacationStatus(sharedPreferences.getString('userId')!);

    if (allowCheckIn) {
      bool checkIn = await calCheckIn();
      if (in_area != true) {
        print('the area$in_area');
        CustomToast.errorToast('you_cannot_check_in_you_are_out_area'.tr);
      } else if (checkIn) {
        CustomAlertDialog.showPresenceAlert(
          title: "do_you_want_to_check_in?".tr,
          message: "you_need_to_confirm_before_you_can_do_presence_now".tr,
          onCancel: () => Get.back(),
          onConfirm: () async {
            await presenceCollection.doc(todayDocId).set(
              {
                "date": DateTime.now().toIso8601String(),
                "status": 'Present',
                "timing": 'On Time',
                
                "checkIn": {
                  "status": timeStatus,
                  "date": DateTime.now().toIso8601String(),
                  "latitude": position.latitude,
                  "longitude": position.longitude,
                  "address": address,
                  "in_area": in_area,
                  "distance": distance,
                }
              },
            );

            ////////////////// putting another function to set the presence status

            Get.back();
            CustomToast.successToast("success_check_in".tr);
          },
        );
      }
    } else {
      CustomAlertDialog.showPresenceAlert(
          title: 'vacations'.tr,
          message:
              'sorry_you_cant_check_in_because_you_have_vacation_do_you_want_to_cancel_vacation_request'
                  .tr,
          onConfirm: () {},
          onCancel: () => Get.back());
        
    }
  }

  checkoutPresence(
    CollectionReference<Map<String, dynamic>> presenceCollection,
    String todayDocId,
    Position position,
    String address,
    double distance,
    bool in_area,
  ) async {
    bool allowCheckOut =
        await checkVacationStatus(sharedPreferences.getString('userId')!);

    if (allowCheckOut) {
      bool chechOut = await calCheckOut();
      if (chechOut) {
        int currentHour = currentTime!.hour * 60 + currentTime!.minute;
        int startHour = startTime!.hour * 60 + startTime!.minute;
        int lateHour = lateTime!.hour * 60 + lateTime!.minute;
        int endHour = endTime!.hour * 60 + endTime!.minute;
        if (currentHour < endHour) {
          print("Check-out time has not arrived yet.");
        } else {
          print("Check-out time has passed.");
        }
        CustomAlertDialog.showPresenceAlert(
          title: "do_you_want_to_check_out".tr,
          message: "you_need_to_confirm_before_you_can_do_presence_now".tr,
          onCancel: () => Get.back(),
          onConfirm: () async {
            await presenceCollection.doc(todayDocId).update(
              {
                "checkOut": {
                  "status": timeStatus,
                  "date": DateTime.now().toIso8601String(),
                  "latitude": position.latitude,
                  "longitude": position.longitude,
                  "address": address,
                  "in_area": in_area,
                  "distance": distance,
                },
                'hoursWork': hoursWork
              },
            );
            Get.back();
            CustomToast.successToast("success_check_out".tr);
          },
        );
      }
    } else {
      CustomAlertDialog.showPresenceAlert(
          title: 'vacations'.tr,
          message:
              'sorry_you_cant_check_out_because_you_have_vacation_do_you_want_to_cancel_vacation_request'
                  .tr,
          onConfirm: () {},
          onCancel: () => Get.back());
    }
  }

  Future<void> processPresence(
      Position position, String address, double distance) async {
    String uid = sharedPreferences.getString('userId')!;
    String todayDocId =
        DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");

    CollectionReference<Map<String, dynamic>> presenceCollection =
        await firestore.collection("user").doc(uid).collection("presence");
    QuerySnapshot<Map<String, dynamic>> snapshotPreference =
        await presenceCollection.get();

    bool in_area = false;
    if (distance <= 200) {
      in_area = true;
    }

    if (snapshotPreference.docs.length == 0) {
      //case :  never presence -> set check in presence
      firstPresence(
          presenceCollection, todayDocId, position, address, distance, in_area);
    } else {
      DocumentSnapshot<Map<String, dynamic>> todayDoc =
          await presenceCollection.doc(todayDocId).get();
      // already presence before ( another day ) -> have been check in today or check out?
      if (todayDoc.exists == true) {
        Map<String, dynamic>? dataPresenceToday = todayDoc.data();
        // case : already check in
        if (dataPresenceToday?["checkOut"] != null) {
          // case : already check in and check out
          CustomToast.successToast("you_already_check_in_and_check_out".tr);
        } else {
          await calHoursWork();
          // case : already check in and not yet check out ( check out )
          checkoutPresence(presenceCollection, todayDocId, position, address,
              distance, in_area);
        }
      } else {
        // case : not yet check in today
        checkinPresence(presenceCollection, todayDocId, position, address,
            distance, in_area);
      }
    }
  }

  Future<void> updatePosition(Position position, String address) async {
    String uid = sharedPreferences.getString('userId')!;
    await firestore.collection("user").doc(uid).update({
      "position": {
        "latitude": position.latitude,
        "longitude": position.longitude,
      },
      "address": address,
    });
  }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('location_services_are_disabled'.tr);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // return Future.error('Location permissions are denied');
        return {
          "message":
              "Unable_to_access_because_you_denied_the_location_request".tr,
          "error": true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return {
        "message":
            "Location_permissions_are_permanently_denied_we_cannot_request_permissions"
                .tr,
        "error": true,
      };
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    return {
      "position": position,
      "message": "Managed to get the position of the device",
      "error": false,
    };
  }
}

class PresenceUpdater {
  Timer? _timer;
  final CollectionReference presenceCollection;

  PresenceUpdater({required this.presenceCollection});

  void start() {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(Duration(hours: 24), (timer) async {
        var now = DateTime.now();
        if (now.hour == 0 && now.minute == 0) {
          // Update the status to 'absence' at 12 AM
          var todayDocId = now.toIso8601String().split('T')[0];
          await presenceCollection.doc(todayDocId).update({
            'status': 'Present',
          });
        }
      });
    }
  }

  void stop() {
    _timer?.cancel();
  }
}
