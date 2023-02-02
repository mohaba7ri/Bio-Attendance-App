// TODO Implement this library.
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:presence/app/modules/languages/controller/languages_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/language_model.dart';
import '../modules/languages/bindings/language_repo.dart';
import '../util/app_constants.dart';

Future<Map<String, Map<String, String>>> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Map<String, Map<String, String>> _languages = Map();
  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(sharedPreferences: Get.find()));
  Get.lazyPut(() => LanguagesController(
      sharedPreferences: Get.find(), apiClient: Get.find()));

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
  return _languages;
}
