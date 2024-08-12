import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/internal/helpers/catch_exception/catch_exception.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      log('AuthLoadingState emitted');
      try {
        final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
        final UserCredential result =
            await firebaseAuth.signInWithEmailAndPassword(
          email: event.name,
          password: event.passwordToLogin,
        );

        log('result ===${result.user?.email}');

        log('result ===${result.user?.uid}');

        emit(AuthLoadedState(userCredential: result));
        log('AuthLoadedState emitted with user: ${result.user?.email}');

      } on FirebaseAuthException catch (e) {
        log('erros is $e');

        emit(AuthErrorState(error: e));
      } catch (e) {
        log('erros is $e');

        CatchException.convertException(e);
      }
    });
    on<RegisterEvent>((event, emit) async {
      emit(AuthLoadingState());

      try {
        final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
        
        final UserCredential result =
            await firebaseAuth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        log('result ===${result.user?.email}');

        log('result ===${result.user?.uid}');

        emit(AuthLoadedState(userCredential: result));
      } on FirebaseAuthException catch (e) {
        log('error is $e');
        emit(AuthErrorState(error: e));
      } catch (e) {
        log('error is $e');

        CatchException.convertException(e);
      }
    });
  }
}
