part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailed extends RegisterState {
  final String errMessage;

  RegisterFailed(this.errMessage);
}
///////////////////////******Create User in databse ****/////////////////////////
///

class CreateUserLoading extends RegisterState {}

class CreateUserSuccess extends RegisterState {}

class CreateUserFailed extends RegisterState {
  final String errMessage;

  CreateUserFailed(this.errMessage);
}
