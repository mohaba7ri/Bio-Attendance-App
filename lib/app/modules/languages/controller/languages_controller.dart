import 'package:Biometric/app/modules/vacation/my_vaction/my_vacation_controller/my_vacation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/language_model.dart';
import '../../../util/app_constants.dart';

class LanguagesController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  LanguagesController(
      {required this.sharedPreferences, required this.apiClient}) {
    loadCurrentLanguage();
   
  }

  Locale _locale = Locale(AppConstants.languages[0].languageCode,
      AppConstants.languages[0].countryCode);
  bool _isLtr = true;
  List<LanguageModel> _languages = [];
  Locale get locale => _locale;
  bool get isLtr => _isLtr;
  List<LanguageModel> get languages => _languages;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  void setSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(
        AppConstants.LANGUAGE_CODE, locale.countryCode.toString());
    sharedPreferences.setString(AppConstants.COUNTRY_CODE, locale.languageCode);
  }

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    if (_locale.languageCode == 'ar') {
      _isLtr = false;
    } else {
      _isLtr = true;
    }

    // apiClient.updateHeader(
    //     token: sharedPreferences.getString(AppConstants.TOKEN),
    //     languageCode: locale.languageCode);
    saveLanguage(_locale);

    update();
  }

  void loadCurrentLanguage() async {
    _locale = Locale(
        sharedPreferences.getString(AppConstants.COUNTRY_CODE) ??
            AppConstants.languages[0].countryCode,
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ??
            AppConstants.languages[0].languageCode);
    _isLtr = _locale.languageCode != 'ar';
    for (int index = 0; index < AppConstants.languages.length; index++) {
      if (AppConstants.languages[index].languageCode == _locale.languageCode) {
        _selectedIndex = index;
        break;
      }
    }
    _languages = [];
    _languages.addAll(AppConstants.languages);
    update();
  }

  void searchLanguage(String query) {
    if (query.isEmpty) {
      _languages = [];
      _languages = AppConstants.languages;
    } else {
      _selectedIndex = -1;
      _languages = [];
      AppConstants.languages.forEach((language) async {
        if (language.languageName.toLowerCase().contains(query.toLowerCase())) {
          _languages.add(language);
        }
      });
    }
    update();
  }
}

class ApiClient extends GetxService {
  final SharedPreferences sharedPreferences;

  String? token = '123';
  Map<String, String>? _mainHeaders;

  ApiClient({required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.TOKEN);
    if (Foundation.kDebugMode) {
      print('Token: $token');
    }
    // updateHeader(
    //     token: token,
    //     languageCode: sharedPreferences.getString(AppConstants.LANGUAGE_CODE));
  }

  // void updateHeader({
  //   String? token,
  //   String? languageCode,
  // }) {
  //   Map<String, String> _header = {};

  //   _header.addAll({
  //     AppConstants.LOCALIZATION_KEY:
  //         languageCode ?? AppConstants.languages[0].languageCode,
  //     'Authorization': token!,
  //   });
  //   _mainHeaders = _header;
  // }
}
