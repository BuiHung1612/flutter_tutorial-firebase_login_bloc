import 'dart:developer';

import 'package:firebase_login_bloc/events/login_event.dart';
import 'package:firebase_login_bloc/repositories/user_repository.dart';
import 'package:firebase_login_bloc/states/login_state.dart';
import 'package:firebase_login_bloc/validators/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;

  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginState.initial()) {
    on<LoginEvent>(
      (event, emit) async {
        log('EVENT:${event}');
        final loginState = state;
        if (event is LoginEventEmailChanged) {
          emit(loginState.cloneAndUpdate(
              isValidEmail: Validators.isValidEmail(event.email)));
        } else if (event is LoginEventPasswordChanged) {
          log('CHECK 23');
          emit(loginState.cloneAndUpdate(
              isValidPassword: Validators.isValidPassword(event.password)));
        } else if (event is LoginEventWithGooglePressed) {
          try {
            await _userRepository.signInWithGoogle();
            emit(LoginState.success());
          } catch (_) {
            emit(LoginState.failure());
          }
        } else if (event is LoginEventWithEmailAndPasswordPressed) {
          log('30 23');
          try {
            await _userRepository.signInWithEmailAndPassword(
                event.email, event.password);
            emit(LoginState.success());
          } catch (_) {
            emit(LoginState.failure());
          }
        }
      },
      // transformer: (events, mapper) {
      //   final debounceStream = events
      //       .where((event) => ((event is LoginEventEmailChanged) ||
      //           (event is LoginEventPasswordChanged)))
      //       .debounceTime(const Duration(milliseconds: 300))
      //       .asyncExpand(mapper);
      //   final nonDebounceStream = events.where((event) =>
      //       ((event is! LoginEventEmailChanged) ||
      //           (event is! LoginEventPasswordChanged)));
      //   return nonDebounceStream.mergeWith([debounceStream]);
      // },
    );
  }
}
