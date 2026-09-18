import '../errors/app_exceptions.dart';

class ApiResponse {
  const ApiResponse({
    required this.statusCode,
    this.body = const <String, Object?>{},
  });

  final int statusCode;
  final Map<String, Object?> body;
}

abstract interface class ApiClient {
  Future<ApiResponse> get(String path);

  Future<ApiResponse> post(String path, {Map<String, Object?> body = const {}});
}

/// Real transport boundary. No endpoint is invented until the backend contract exists.
class UnconfiguredApiClient implements ApiClient {
  const UnconfiguredApiClient({required this.integration});

  final String integration;

  @override
  Future<ApiResponse> get(String path) =>
      throw IntegrationNotConfiguredException(integration);

  @override
  Future<ApiResponse> post(
    String path, {
    Map<String, Object?> body = const {},
  }) => throw IntegrationNotConfiguredException(integration);
}
