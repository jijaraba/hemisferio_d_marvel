import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_utilities/json_utilities.dart';

class AppLocalizations {
  static late Map<dynamic, dynamic> _localizedValues;

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  String text(String key, {Map<String, dynamic>? values}) {
    final translation = JSONUtils().get(
      _localizedValues as Map<String, dynamic>,
      key,
      '** $key no found',
    ) as String;

    if (values == null) return translation;

    return values.entries.fold(translation, (prev, element) {
      return prev.replaceAll('{${element.key}}', element.value.toString());
    });
  }

  Map<String, dynamic> paramToText(String key, dynamic value) {
    return <String, dynamic>{}..addEntries(
      <MapEntry<String, dynamic>>[MapEntry<String, dynamic>(key, value)],
    );
  }

  static Future<AppLocalizations> load(String flavor, Locale locale) async {
    final appLocalizations = AppLocalizations();
    final jsonContent = await rootBundle.loadString(
      'locale/i18n_${locale.languageCode}.json',
    );

    _localizedValues = json.decode(jsonContent) as Map<dynamic, dynamic>;

    return appLocalizations;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  AppLocalizationsDelegate(this.flavor);

  final String flavor;

  @override
  bool isSupported(Locale locale) =>
      <String>['es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations.load(flavor, locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
