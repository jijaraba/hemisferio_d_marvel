import 'package:flutter/material.dart';
import 'package:marvel_hemisferio/src/config/localizations.dart';

extension ToBuildContextX on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this);

  ThemeData get theme => Theme.of(this);
}

extension StringX on String {

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}