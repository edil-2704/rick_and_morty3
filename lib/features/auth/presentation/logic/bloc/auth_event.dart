part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String name;
  final String passwordToLogin;

  LoginEvent({
    required this.name,
    required this.passwordToLogin,
  });
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;

  RegisterEvent({
    required this.email,
    required this.password,
  });
}
