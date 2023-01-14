import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:presence/app/controllers/page_index_controller.dart';
import 'package:presence/app/controllers/presence_controller.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  GetStorage().writeIfNull('darkMode', false);
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  await translator.init(
    localeType: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/langs/',
  );
  Get.put(PresenceController(), permanent: true);
  Get.put(PageIndexController(), permanent: true);
  //Get.put(AddVacationTypeController());
  runApp(
    StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return GetMaterialApp(
          title: "Application",
          debugShowCheckedModeBanner: false,
          initialRoute:
              snapshot.data != null ? Routes.list_Branch : Routes.list_Branch,
          getPages: AppPages.routes,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'inter',
          ),
        );
      },
    ),
  );
}
