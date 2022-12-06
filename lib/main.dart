import 'package:flutter/material.dart';
import 'package:presence/app/modules/fingerprint_auth/login.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // Get.put(PresenceController(), permanent: true);
  // Get.put(PageIndexController(), permanent: true);
  // // runApp(
  // //   StreamBuilder<User?>(
  // //     stream: FirebaseAuth.instance.authStateChanges(),
  // //     builder: (context, snapshot) {
  // //       if (snapshot.connectionState == ConnectionState.waiting) {
  // //         return MaterialApp(
  // //           home: Scaffold(
  // //             body: Center(
  // //               child: CircularProgressIndicator(),
  // //             ),
  // //           ),
  // //         );
  // //       }
  // //       return GetMaterialApp(
  // //         title: "Application",
  // //         debugShowCheckedModeBanner: false,
  // //         initialRoute: snapshot.data != null ? Routes.HOME : Routes.LOGIN,
  // //         getPages: AppPages.routes,
  // //         theme: ThemeData(
  // //           scaffoldBackgroundColor: Colors.white,
  // //           fontFamily: 'inter',
  // //         ),
  // //       );
  // //     },
  // //   ),
  // // );
  WidgetsFlutterBinding.ensureInitialized();

  runApp(Login());
}
