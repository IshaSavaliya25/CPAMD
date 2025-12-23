import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/l10n/app_localizations.dart';


class LocaleService with ChangeNotifier {
  Locale _locale = Locale('en');

  Locale get locale => _locale;

  LocaleService() {
    _loadLocale();
  }
  void _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    _locale = Locale(prefs.getString('langCode') ?? 'en');
    notifyListeners();
  }

  void changeLanguage(String langCode) async {
    _locale = Locale(langCode);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('langCode', langCode);
  }

  static const localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  static Locale? localeResolutionCallback(locales, supportedLocales) {
    final deviceLocale = locales?.isNotEmpty == true ? locales!.first : null;

    if (deviceLocale != null) {
      for (var locale in supportedLocales) {
        if (locale.languageCode == deviceLocale.languageCode) {
          return locale;
        }
      }
    }

    return supportedLocales.first;
  }
}
