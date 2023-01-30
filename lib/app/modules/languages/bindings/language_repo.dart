import 'package:flutter/material.dart';

import '../../../model/language_model.dart';
import '../../../util/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext? context}) {
    return AppConstants.languages;
  }
}
