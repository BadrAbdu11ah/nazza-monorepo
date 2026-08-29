import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

// خطأ السيرفر
class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure(super.message, {this.statusCode});
}

class OfflineFailure extends Failure {
  const OfflineFailure(super.message);
}

class EmptyDataFailure extends Failure {
  const EmptyDataFailure(super.message);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}
