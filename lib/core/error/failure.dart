abstract class Failure {
  String get message;
}

class ServerFailure extends Failure {
  @override
  final String message;

  ServerFailure(this.message);

  @override
  String toString() {
    return 'ServerFailure: $message';
  }
}


class ApiExceptionFailure extends Failure {
  @override
  final String message;

  ApiExceptionFailure(this.message);

  @override
  String toString() {
    return message;
  }
}
