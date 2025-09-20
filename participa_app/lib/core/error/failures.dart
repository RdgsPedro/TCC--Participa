import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({this.message = ''});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Erro no servidor'});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Erro no cache'});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'Erro de conexão'});
}

class AuthFailure extends Failure {
  const AuthFailure({super.message = 'Erro de autenticação'});
}
