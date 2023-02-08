import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:presence/app/controllers/page_index_controller.dart';
import 'package:presence/app/controllers/presence_controller.dart';
import 'package:presence/app/modules/home/controllers/home_controller.dart';
import 'package:presence/app/modules/languages/controller/languages_controller.dart';
import 'package:presence/app/modules/profile/controllers/profile_controller.dart';
import 'app/util/app_constants.dart';
import 'app/util/messages.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'app/helper/get_di.dart' as di;

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Map<String, Map<String, String>> _languages = await di.init();

  Get.put(PresenceController(), permanent: true);
  Get.put(PageIndexController(), permanent: true);
  Get.put(ProfileController());

  Get.put(HomeController(), permanent: true);

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
        return GetBuilder<LanguagesController>(builder: (languageController) {
          return GetMaterialApp(
            //  title: "Application",
            debugShowCheckedModeBanner: false,
            initialRoute:
                snapshot.data != null ? Routes.MY_VACATION : Routes.MY_VACATION,
            getPages: AppPages.routes,
            locale: languageController.locale,
            translations: Messages(languages: _languages),
            fallbackLocale: Locale(AppConstants.languages[0].languageCode,
                AppConstants.languages[0].countryCode),
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              fontFamily: 'inter',
            ),
          );
        });
      },
    ),
  );
}
