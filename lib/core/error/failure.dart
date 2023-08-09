abstract class Failure {
  String get message;
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure(this.message);

  @override
  String toString() {
    return 'ServerFailure: $message';
  }
}


class ApiExceptionFailure extends Failure {
  final String message;

  ApiExceptionFailure(this.message);

  @override
  String toString() {
    return message;
  }
}
