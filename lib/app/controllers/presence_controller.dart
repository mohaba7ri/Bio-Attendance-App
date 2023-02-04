import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/widgets/dialog/custom_alert_dialog.dart';
import 'package:presence/app/widgets/toast/custom_toast.dart';
import 'package:presence/company_data.dart';

class PresenceController extends GetxController {
  RxBool isLoading = false.obs;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? lateTime;
  DateTime currentDate = DateTime.now();
  String? timeStatus;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCompanySetting();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getCompanySetting() async {
    firestore
        .collection('companySettings')
        .where('companyId', isEqualTo: 'J5RB7gH6aPnw8uVoqndS')
        .get()
        .then((QuerySnapshot query) {
      query.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        startTime = DateTime.parse(data['startTime']);
        endTime = DateTime.parse(data['endTime']);
        lateTime = DateTime.parse(data['lateTime']);

        print('the company ID${data['companyId']}');
        print('the company ID${startTime.runtimeType}');
      });
    
    });
  }

  presence() async {
    isLoading.value = true;
    Map<String, dynamic> _determinePosition = await determinePosition();
    if (!_determinePosition["error"]) {
      Position position = _determinePosition["position"];
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      String address =
          "${placemarks.first.street}, ${placemarks.first.subLocality}, ${placemarks.first.locality}";
      double distance = Geolocator.distanceBetween(
          CompanyData.office['latitude'],
          CompanyData.office['longitude'],
          position.latitude,
          position.longitude);
      //get the company Settings
      await getCompanySetting();
      // update position ( store to database )
      await updatePosition(position, address);
      // presence ( store to database )
      await processPresence(position, address, distance);
      isLoading.value = false;
    } else {
      isLoading.value = false;
      Get.snackbar("There is an error", _determinePosition["message"]);
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
      var currentDate = DateTime.now();
      if (status == 'approved' &&
          currentDate.isAfter(startDate) &&
          currentDate.isBefore(endDate)) {
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
    bool allowCheckIn = await checkVacationStatus(auth.currentUser!.uid);
    if (allowCheckIn) {
      CustomAlertDialog.showPresenceAlert(
        title: "Do you want to check in?",
        message: "you need to confirm before you\ncan do presence now",
        onCancel: () => Get.back(),
        onConfirm: () async {
          await presenceCollection.doc(todayDocId).set(
            {
              "date": DateTime.now().toIso8601String(),
              "status": 'presence',
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
          CustomToast.successToast("success check in");
        },
      );
    } else {
      CustomAlertDialog.showPresenceAlert(
          title: 'Vacation Request',
          message:
              'Sorry you can\'t check in because you have vacation\n Do you want to cancel vacation request',
          onConfirm: () {},
          onCancel: () => Get.back());
    }
  }

  checkinPresence(
    CollectionReference<Map<String, dynamic>> presenceCollection,
    String todayDocId,
    Position position,
    String address,
    double distance,
    bool in_area,
  ) async {
    bool allowCheckIn = await checkVacationStatus(auth.currentUser!.uid);
    if (allowCheckIn) {
      CustomAlertDialog.showPresenceAlert(
        title: "Do you want to check in?",
        message: "you need to confirm before you\ncan do presence now",
        onCancel: () => Get.back(),
        onConfirm: () async {
          await presenceCollection.doc(todayDocId).set(
            {
              "date": DateTime.now().toIso8601String(),
              "status": 'absence',
              "checkIn": {
                "status":timeStatus,
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
          CustomToast.successToast("success check in");
        },
      );
    } else {
      CustomAlertDialog.showPresenceAlert(
          title: 'Vacation Request',
          message:
              'Sorry you can\'t check in because you have vacation\n Do you want to cancel vacation request',
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
    bool allowCheckOut = await checkVacationStatus(auth.currentUser!.uid);
    if (allowCheckOut) {
      CustomAlertDialog.showPresenceAlert(
        title: "Do you want to check out?",
        message: "you need to confirm before you\ncan do presence now",
        onCancel: () => Get.back(),
        onConfirm: () async {
          await presenceCollection.doc(todayDocId).update(
            {
              "checkOut": {
                "status":timeStatus,
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
          CustomToast.successToast("success check out");
        },
      );
    } else {
      CustomAlertDialog.showPresenceAlert(
          title: 'Vacation Request',
          message:
              'Sorry you can\'t check out because you have vacation\n Do you want to cancel vacation request',
          onConfirm: () {},
          onCancel: () => Get.back());
    }
  }

  Future<void> processPresence(
      Position position, String address, double distance) async {
    String uid = auth.currentUser!.uid;
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
          CustomToast.successToast("you already check in and check out");
        } else {
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
    String uid = auth.currentUser!.uid;
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
      return Future.error('Location services are disabled.');
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
          "message": "Unable to access because you denied the location request",
          "error": true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return {
        "message":
            "Location permissions are permanently denied, we cannot request permissions.",
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
            'status': 'absence',
          });
        }
      });
    }
  }

  void stop() {
    _timer?.cancel();
  }
}
