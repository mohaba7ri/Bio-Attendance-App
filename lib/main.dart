import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:presence/app/controllers/page_index_controller.dart';
import 'package:presence/app/controllers/presence_controller.dart';
import 'package:presence/app/modules/home/controllers/home_controller.dart';
import 'package:presence/app/modules/languages/controller/languages_controller.dart';
import 'package:presence/app/modules/profile/controllers/profile_controller.dart';
import 'package:presence/app/util/images.dart';
import 'package:presence/app/widgets/toast/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/util/app_constants.dart';
import 'app/util/messages.dart';
import 'app/widgets/dialog/custom_alert_dialog.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'app/helper/get_di.dart' as di;
import 'package:firebase_messaging/firebase_messaging.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Map<String, Map<String, String>> _languages = await di.init();
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put(PresenceController(), permanent: true);
  Get.put(PageIndexController(), permanent: true);
  Get.put(ProfileController());

  Get.put(HomeController(), permanent: true);
  var fbm = FirebaseMessaging.instance;
  fbm.getToken().then((token) async {
    print('the device token: $token');

    sharedPreferences.setString('deviceToken', token!);
  });
  FirebaseMessaging.onMessage.listen((event) {
    CustomAlertDialog.customAlert(
        icon: Images.support,
        message: '${event.notification!.body}',
        onConfirm: () {},
        onCancel: () {});
    print('the message: ${event.notification!.body}');
    CustomToast.successToast(event.notification!.body);
    Get.showSnackbar(GetSnackBar(
      duration: Duration(seconds: 2),
      titleText: Text('${event.notification!.title}'),
      messageText: Text('${event.notification!.body}'),
    ));
  });

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
        return GetBuilder<LanguagesController>(
          builder: (languageController) {
            return GetMaterialApp(
              //  title: "Application",
              debugShowCheckedModeBanner: false,
              initialRoute: snapshot.data != null ? Routes.LOGIN : Routes.LOGIN,
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
          },
        );
      },
    ),
  );
}
