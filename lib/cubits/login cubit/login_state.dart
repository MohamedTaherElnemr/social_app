part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String uId;

  LoginSuccess(this.uId);
}

class LoginIFailed extends LoginState {
  final String errMessage;

  LoginIFailed(this.errMessage);
}
