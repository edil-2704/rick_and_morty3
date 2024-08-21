import 'package:firebase_auth/firebase_auth.dart';
import 'package:rick_and_morty/features/auth/domain/repository/auth_repository.dart';

class AuthUseCase {
  final AuthRepository authRepository;

  AuthUseCase({required this.authRepository});

  Future<UserCredential?> signIn(
      {required String email, required String password}) async {
    return await authRepository.signIn(
      email: email,
      password: password,
    );
  }

  Future<UserCredential?> signUp(
      {required String email, required String password}) async {
    return await authRepository.signUp(email: email, password: password);
  }

  Future<UserCredential?> signOut () async {
    return await authRepository.signOut();
  }
}
