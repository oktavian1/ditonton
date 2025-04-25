class ServerException implements Exception {
  final String message;

  ServerException([this.message = "Server error occurred"]);

  @override
  String toString() => 'ServerException: $message';
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);

  @override
  String toString() => 'DatabaseException: $message';
}
