sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => message;
}

class ValidationException extends AppException {
  const ValidationException(super.message);
}

class NetworkException extends AppException {
  const NetworkException([
    super.message = 'Check your internet connection and try again.',
  ]);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([
    super.message = 'Your session has expired. Please sign in again.',
  ]);
}

class ServerException extends AppException {
  const ServerException([
    super.message = 'The service is temporarily unavailable. Please try again.',
  ]);
}

class TimeoutException extends AppException {
  const TimeoutException([
    super.message = 'The request timed out. Please try again.',
  ]);
}

class IntegrationNotConfiguredException extends AppException {
  const IntegrationNotConfiguredException(String integration)
    : super(
        '$integration is configured for real mode but has no API contract or base URL.',
      );
}
