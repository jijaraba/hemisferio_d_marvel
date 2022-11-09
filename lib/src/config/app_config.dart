final _privateError = UnsupportedError('Use AppConfig() implementation');

class AppConfig {
  const factory AppConfig({
    required String serverBaseUrl,
    required String appName,
    required String privateKey,
    required String publicKey,
  }) = _AppConfig;

  const AppConfig.none();

  String get serverBaseUrl => throw _privateError;

  String get appName => throw _privateError;

  String get privateKey => throw _privateError;

  String get publicKey => throw _privateError;
}

class _AppConfig implements AppConfig {
  const _AppConfig({
    required this.serverBaseUrl,
    required this.appName,
    required this.privateKey,
    required this.publicKey,
  });

  @override
  final String serverBaseUrl;

  @override
  final String appName;

  @override
  final String privateKey;

  @override
  final String publicKey;
}
