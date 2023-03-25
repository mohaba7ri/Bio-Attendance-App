// TODO Implement this library.
import 'dart:convert';

import 'package:Biometric/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/biometric_controller.dart';
import '../controllers/loading_config.dart';
import '../controllers/page_index_controller.dart';
import '../controllers/presence_controller.dart';
import '../model/language_model.dart';
import '../modules/Branches/general_settings/controller/branch_seting_controlleer.dart';
import '../modules/Company/company_settings/controller/company_seting_controlleer.dart';
import '../modules/home/controllers/home_controller.dart';
import '../modules/languages/bindings/language_repo.dart';
import '../modules/languages/controller/languages_controller.dart';
import '../modules/profile/controllers/profile_controller.dart';
import '../modules/reports/allBranchesReports/view/pdf.dart';
import '../modules/reports/allBranchesReports/view/pdf_branch_reports.dart';
import '../modules/vacation/my_vaction/my_vacation_controller/my_vacation_static_controller.dart';
import '../util/app_constants.dart';
import '../widgets/custom_animation.dart';

Future<Map<String, Map<String, String>>> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Map<String, Map<String, String>> _languages = Map();
  Get.lazyPut(() => LanguageRepo());
  PdfAllBranch.init();
  PdfGenerator.init();

  Get.lazyPut(() => BiometricController(sharedPreferences: Get.find()));
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(sharedPreferences: Get.find()));
  Get.lazyPut(() => LanguagesController(
      sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() =>
      LoginController(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.put(
    PresenceController(sharedPreferences: Get.find()),
  );
  Get.put(PageIndexController(), permanent: true);
  Get.put(ProfileController(sharedPreferences: Get.find()));
  Get.put(LoadingConfig());
  Get.put(
    HomeController(sharedPreferences: Get.find()),
  );

  Get.lazyPut(() => BranchSettingController());
  Get.lazyPut(() => MyVacationStaticController(sharedPreferences: Get.find()),
      fenix: true);
  Get.lazyPut<CompanySettingController>(() => CompanySettingController(),
      fenix: true);

  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/langs/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();
    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        _json;
  }

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false
      ..customAnimation = CustomAnimation();
  }

  return _languages;
}
