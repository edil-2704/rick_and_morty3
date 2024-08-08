/* External dependencies */
import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initMyHive() async {
  await Hive.initFlutter();

  await Future.wait([
    Hive.openBox('language'),
  ]);
}

class LocalizationHive {
  static String getLocale() {
    final localeBox = Hive.box('language');

    final String locale = localeBox.get('locale', defaultValue: 'ru');
    log(locale);

    return locale;
  }

  static void setLocale(String lang) {
    final localeBox = Hive.box('language');

    localeBox.put('locale', lang);
  }
}
