 import 'package:presence/app/util/images.dart';

import '../model/language_model.dart';

class AppConstants{
  static const String COUNTRY_CODE = 'Biometric_country_code';
  static const String LANGUAGE_CODE = 'Biometric_language_code';
  static const String LOCALIZATION_KEY = 'X-localization';
  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.english, languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: Images.arabic, languageName: 'عربى', countryCode: 'SA', languageCode: 'ar'),
   
  ];
}
