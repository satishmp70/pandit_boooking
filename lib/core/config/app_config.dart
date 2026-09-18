enum ProviderMode { mock, real }

enum MockScenario {
  success,
  networkError,
  unauthorized,
  serverError,
  timeout,
  invalid,
}

class AppConfig {
  const AppConfig._({
    required this.environment,
    required this.authProvider,
    required this.bookingProvider,
    required this.paymentProvider,
    required this.authBaseUrl,
    required this.bookingBaseUrl,
    required this.paymentBaseUrl,
    required this.mockScenario,
  });

  factory AppConfig.fromEnvironment() {
    return AppConfig._(
      environment: const String.fromEnvironment(
        'APP_ENV',
        defaultValue: 'development',
      ),
      authProvider: _provider(
        const String.fromEnvironment('AUTH_PROVIDER', defaultValue: 'mock'),
      ),
      bookingProvider: _provider(
        const String.fromEnvironment('BOOKING_PROVIDER', defaultValue: 'mock'),
      ),
      paymentProvider: _provider(
        const String.fromEnvironment('PAYMENT_PROVIDER', defaultValue: 'mock'),
      ),
      authBaseUrl: const String.fromEnvironment('AUTH_BASE_URL'),
      bookingBaseUrl: const String.fromEnvironment('BOOKING_BASE_URL'),
      paymentBaseUrl: const String.fromEnvironment('PAYMENT_BASE_URL'),
      mockScenario: _scenario(
        const String.fromEnvironment('MOCK_SCENARIO', defaultValue: 'success'),
      ),
    );
  }

  const AppConfig.test({
    this.environment = 'test',
    this.authProvider = ProviderMode.mock,
    this.bookingProvider = ProviderMode.mock,
    this.paymentProvider = ProviderMode.mock,
    this.authBaseUrl = '',
    this.bookingBaseUrl = '',
    this.paymentBaseUrl = '',
    this.mockScenario = MockScenario.success,
  });

  final String environment;
  final ProviderMode authProvider;
  final ProviderMode bookingProvider;
  final ProviderMode paymentProvider;
  final String authBaseUrl;
  final String bookingBaseUrl;
  final String paymentBaseUrl;
  final MockScenario mockScenario;

  bool get isProduction => environment == 'production';

  static ProviderMode _provider(String value) =>
      value.toLowerCase() == 'real' ? ProviderMode.real : ProviderMode.mock;

  static MockScenario _scenario(String value) {
    return MockScenario.values.firstWhere(
      (scenario) => scenario.name == value.toLowerCase(),
      orElse: () => MockScenario.success,
    );
  }
}
