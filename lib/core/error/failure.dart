abstract class Failure {
  final String _message;

  const Failure({
    required String message,
  }) : _message = message;
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}
