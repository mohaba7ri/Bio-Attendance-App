import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers/helpers.dart';
import 'package:ionicons/ionicons.dart';

import '../../../widgets/dialog/app_dialog.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: []),
      body: Column(children: [
        ExpansionTile(
          expandedAlignment: Alignment.topLeft,
          title: Row(
            children: [
              Icon(Icons.home_filled),
              Text('Manage company'),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(onPressed: () {}, child: Text('Update company')),
                  TextButton(
                      onPressed: () {}, child: Text('Add company branch')),
                  TextButton(onPressed: () {}, child: Text('Company Settings')),
                ],
              ),
            ),
          ],
        ),
        ExpansionTile(
          expandedAlignment: Alignment.topLeft,
          title: Row(
            children: [
              Icon(
                Ionicons.person_add_outline,
                color: Colors.teal,
              ),
              Text('Manage Employee'),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(onPressed: () {}, child: Text('Add ameen')),
                  TextButton(
                      onPressed: () {}, child: Text('Update Al mohanad')),
                ],
              ),
            ),
          ],
        ),
        ExpansionTile(
          expandedAlignment: Alignment.topLeft,
          title: Row(
            children: [
              Icon(Icons.person_outline),
              Text('Manage Profile'),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(onPressed: () {}, child: Text('Update profile')),
                  TextButton(onPressed: () {}, child: Text('Change password'))
                ],
              ),
            ),
          ],
        ),
        profileItem(
            icon: Ionicons.globe_outline,
            title: "language",
            subtitle: 'translator.activeLanguageCode',
            iconBackground: const Color(0xff3DB2FF),
            onTap: () {
              // translator.setNewLanguage(
              //   context,
              //   newLanguage:
              //       translator.activeLanguageCode == 'ar' ? 'en' : 'ar',
              //   remember: true,
              // );
            }),
        profileItem(
            icon: Ionicons.sunny,
            title: "theme",
            subtitle: 'them',
            iconBackground: const Color(0xffFC5404),
            onTap: () {
              // if (GetStorage().read("darkMode")) {
              //   setState(() {
              //     Get.changeThemeMode(ThemeMode.light);
              //     GetStorage().write("darkMode", false);
              //   });
              // } else {
              //   setState(() {
              //     Get.changeThemeMode(ThemeMode.dark);
              //     GetStorage().write("darkMode", true);
              //   });
              // }
            }),
        profileItem(
            icon: Ionicons.log_out_outline,
            title: "logout",
            subtitle: "logoutDescription",
            iconBackground: const Color(0xffDF2E2E),
            onTap: () {
              AppWidgets().MyDialog(
                  context: context,
                  asset: const Icon(
                    Ionicons.information_circle,
                    size: 80,
                    color: Colors.white,
                  ),
                  background: const Color(0xff3DB2FF),
                  title: "logout",
                  subtitle: "logoutConfirm",
                  confirm: ElevatedButton(
                      onPressed: () async {
                        // await FirebaseMessaging.instance
                        //     .unsubscribeFromTopic("user");
                        // await FirebaseMessaging.instance.unsubscribeFromTopic(
                        //     FirebaseAuth.instance.currentUser!.uid);

                        // await FirebaseAuth.instance.signOut().then(
                        //     (value) => Get.offAll(() => const SplashPage()));
                      },
                      child: Text("yes")),
                  cancel: ElevatedButton(
                      onPressed: () async {
                        Get.back();
                      },
                      style: Get.theme.elevatedButtonTheme.style!.copyWith(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffDF2E2E))),
                      child: Text("no")));
            }),
      ]),
    );
  }

  Widget profileItem(
      {required IconData icon,
      required Color iconBackground,
      required String title,
      required String subtitle,
      Function()? onTap}) {
    return StatefulBuilder(builder: (context, _) {
      return Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(borderRadius: EdgeRadius.all(10)),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: EdgeRadius.all(10)),
          onTap: onTap,
          trailing: Icon(Ionicons.chevron_forward),
          // trailing: onTap != null
          //     ? Icon(translator.activeLanguageCode == 'ar'
          //         ? Ionicons.chevron_back
          //         : Ionicons.chevron_forward)
          //     : null,
          leading: Card(
            shape: RoundedRectangleBorder(borderRadius: EdgeRadius.all(10)),
            color: iconBackground,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(
            subtitle,
          ),
        ),
      );
    });
  }
}
