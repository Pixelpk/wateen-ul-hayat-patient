import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../service/local_service/local_keys.dart';
import 'en_US.dart';
import 'pt_BR.dart';

class TranslationService extends Translations {
  static Locale? get locale => storage.read(LOCALKEY_english) == null ||
      storage.read(LOCALKEY_english) == true
      ? Locale('en_US')
      : Locale("ar_DZ");
  static final fallbackLocale = Locale('en', 'US');
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'ar_DZ': ar_DZ,
      };
}
