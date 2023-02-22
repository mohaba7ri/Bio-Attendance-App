import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:presence/app/routes/app_pages.dart';
import 'package:presence/app/widgets/toast/custom_toast.dart';
import 'package:presence/company_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../util/images.dart';
import '../../../widgets/dialog/custom_alert_dialog.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;

  RxString officeDistance = "-".obs;
  SharedPreferences sharedPreferences;
  HomeController({required this.sharedPreferences});

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Timer? timer;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void onInit() async {
    super.onInit();
    await initialMessage();
    await getMessage();

    _firebaseMessaging.subscribeToTopic("notifications");

    requestPermission();
    timer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (Get.currentRoute == Routes.HOME) {
        getDistanceToOffice().then((value) {
          officeDistance.value = value;
        });
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Get.toNamed(Routes.LIST_VIEW_REQUESTS);
    });

    loadFCM();

    listenFCM();
  }

  initialMessage() async {
    var message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      Get.toNamed(Routes.MANAGE_VACATION);
    }
  }

  requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  // Replace with server token from firebase console settings.
  final String? serverToken =
      'AAAAWoxIhHs:APA91bExI1ipt8E9Weo3zhAyTz9EGdajlGrbvX3pkpzkgkTsrJkl_6FH0Y49rgrKunJPM6p51y2EpwRccjaix59YRwgKPhchHs7z29Fosel75Y4lqPSLHep6Z3h0bV7LhSAk2meOjg1K';

  final FirebaseMessaging? firebaseMessaging = FirebaseMessaging.instance;

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications',
        // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  getMessage() async {
    await FirebaseMessaging.onMessage.listen((message) {
      String? _title = '${message.notification!.title}' + ' \n ';
      CustomToast.successToast(message.notification!.title);
      CustomAlertDialog.customAlert(
          icon: Images.holidays,
          message: '$_title ${message.notification!.body} ',
          onCancel: () => Get.back(),
          onConfirm: () => Get.toNamed(Routes.LIST_VIEW_REQUESTS));
      update();
    });
  }

  Future sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverToken',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body.toString(),
              'title': title.toString()
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': title
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }

  launchOfficeOnMap() {
    try {
      MapsLauncher.launchCoordinates(
        CompanyData.office['latitude'],
        CompanyData.office['longitude'],
      );
    } catch (e) {
      CustomToast.errorToast('Error : ${e}');
    }
  }

  Future<String> getDistanceToOffice() async {
    print('calleeeed');
    Map<String, dynamic> determinePosition = await _determinePosition();
    if (!determinePosition["error"]) {
      Position position = determinePosition["position"];
      double distance = Geolocator.distanceBetween(
          CompanyData.office['latitude'],
          CompanyData.office['longitude'],
          position.latitude,
          position.longitude);
      if (distance > 1000) {
        return "${(distance / 1000).toStringAsFixed(2)}km";
      } else {
        return "${distance.toStringAsFixed(2)}m";
      }
    } else {
      return "-";
    }
  }

  Future<Map<String, dynamic>> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Get.rawSnackbar(
        title: 'GPS is off',
        message: 'you need to turn on gps',
        duration: Duration(seconds: 3),
      );
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

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = sharedPreferences.getString('userId')!;

    yield* firestore.collection("user").doc(uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamLastPresence() async* {
    String uid =sharedPreferences.getString('userId')!;
    //uid.isEmpty ? sharedPreferences.getString('userId')! : uid;
    yield* firestore
        .collection("user")
        .doc(uid)
        .collection("presence")
        .orderBy("date", descending: true)
        .limitToLast(5)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamTodayPresence() async* {
    String uid =  sharedPreferences.getString('userId')!;
   
    String todayDocId =
        DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");
    yield* firestore
        .collection("user")
        .doc(uid)
        .collection("presence")
        .doc(todayDocId)
        .snapshots();
  }
}
