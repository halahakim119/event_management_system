class ServerException implements Exception {}

class EmptyCacheException implements Exception {}

class OfflineException implements Exception {}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() {
    return 'ApiException: $message';
  }
}
