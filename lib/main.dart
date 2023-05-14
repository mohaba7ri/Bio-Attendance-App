import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'app/modules/languages/controller/languages_controller.dart';
import 'app/util/app_constants.dart';
import 'app/util/messages.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'app/helper/get_di.dart' as di;
import 'package:firebase_messaging/firebase_messaging.dart';

import 'app/routes/app_pages.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Map<String, Map<String, String>> _languages = await di.init();
  final sharedPreferences = await SharedPreferences.getInstance();

  var fbm = FirebaseMessaging.instance;
  fbm.getToken().then((token) async {
    print('the device token: $token');

    sharedPreferences.setString('deviceToken', token!);
  });

  FirebaseMessaging.onMessage.listen((event) {
    print('the message: ${event.notification!.body}');
  });
  RxBool isCompanyExist = false.obs;

  Future<void> checkCompanyExist() async {
    final QuerySnapshot companySetting =
        await FirebaseFirestore.instance.collection("company").get();

    if (companySetting.docs.isNotEmpty) {
      isCompanyExist.value = true;
    }
  }

  await checkCompanyExist();
  runApp(
    StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {}
        return GetBuilder<LanguagesController>(
          builder: (languageController) {
            return GetMaterialApp(
              //  title: "Application",
              debugShowCheckedModeBanner: false,
              initialRoute: isCompanyExist.isTrue
                  ? snapshot.data != null
                      ? Routes.HOME
                      : Routes.LOGIN
                  : Routes.COMPANYSIGNUP,
              getPages: AppPages.routes,
              builder: EasyLoading.init(),
              locale: languageController.locale,
              translations: Messages(languages: _languages),
              fallbackLocale: Locale(AppConstants.languages[0].languageCode,
                  AppConstants.languages[0].countryCode),
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                fontFamily: 'inter',
              ),
            );
          },
        );
      },
    ),
 
  );
}
