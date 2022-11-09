import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:marvel_hemisferio/dependencies.dart';
import 'package:marvel_hemisferio/src/config/config_develop.dart';
import 'package:marvel_hemisferio/src/config/localizations.dart';
import 'package:marvel_hemisferio/src/core/presentation/theme/theme.dart';
import 'package:marvel_hemisferio/src/core/utils/common_extensions.dart';
import 'package:marvel_hemisferio/src/core/utils/logger.dart';
import 'package:marvel_hemisferio/src/presentation/routes/app_routes.dart';

Future<void> mainCommon(Environment env) async {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(
    () async {
      await SystemChrome.setPreferredOrientations(
        <DeviceOrientation>[DeviceOrientation.portraitUp],
      );
      HttpOverrides.global = TempHttpOverrides();
      await _configureSystemUI();
      FlutterError.onError = _handleFlutterError;
      runApp(
        ProviderScope(
          overrides: [appConfigPod.overrideWithValue(config)],
          child: const App(),
        ),
      );
    },
    _handleError,
  );
}

class App extends HookConsumerWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharedPreferences = ref.watch(preferencesPod);

    return sharedPreferences.when(
      loading: () => const Material(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Material(
        child: Center(child: Text(e.toString())),
      ),
      data: (_) {
        final config = ref.watch(appConfigPod);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          locale: const Locale('es'),
          localizationsDelegates: <LocalizationsDelegate<dynamic>>[
            AppLocalizationsDelegate(config.appName),
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const <Locale>[
            Locale('en'),
            Locale('es'),
          ],
          onGenerateTitle: (ctx) => ctx.localizations.text('common.app_name'),
          theme: materialTheme,
          routeInformationProvider: router.routeInformationProvider,
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
        );
      },
    );
  }
}

Future<void> _configureSystemUI() {
  return SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

void _handleFlutterError(FlutterErrorDetails details) {
  FlutterError.dumpErrorToConsole(details);
}

void _handleError(Object error, StackTrace stack) {
  logger.e('App Zone Error', error, stack);
}

class TempHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (_, __, ___) => true;
  }
}
