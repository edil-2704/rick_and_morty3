part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitialState extends AuthState {}
final class AuthLoadingState extends AuthState {}
final class AuthLoadedState extends AuthState {
  final UserCredential userCredential;

  AuthLoadedState({required this.userCredential});
}


final class AuthErrorState extends AuthState {
  final FirebaseException error;


  AuthErrorState({required this.error});
}
