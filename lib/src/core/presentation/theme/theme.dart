library core.presentation.theme;

import 'package:flutter/material.dart';
import 'package:marvel_hemisferio/src/core/presentation/widgets/widgets.dart';
import 'package:marvel_hemisferio/src/core/res/res.dart';

part 'shape.dart';
part 'type.dart';

final ThemeData materialTheme = ThemeData(
  primaryColor: UIColors.white,
  colorScheme: const ColorScheme.light(
    primary: UIColors.red100,
    onPrimary: UIColors.red100,
    secondary: UIColors.red100,
    onSecondary: UIColors.white,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: UIColors.white,
    selectionHandleColor: UIColors.white,
    selectionColor: UIColors.white,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: SlidePageTransitionBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: UIColors.red100,
    unselectedItemColor: UIColors.textGrey,
    backgroundColor: Color(0xFFFFFFFF),
  ),
);
