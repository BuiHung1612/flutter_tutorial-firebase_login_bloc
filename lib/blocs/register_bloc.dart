import 'package:firebase_login_bloc/events/login_event.dart';
import 'package:firebase_login_bloc/events/register_event.dart';
import 'package:firebase_login_bloc/repositories/user_repository.dart';
import 'package:firebase_login_bloc/states/login_state.dart';
import 'package:firebase_login_bloc/states/register_state.dart';
import 'package:firebase_login_bloc/validators/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository _userRepository;

  RegisterBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(RegisterState.initial()) {
    on<RegisterEvent>(
      (event, emit) async {
        final registerState = state;
        if (event is RegisterEventEmailChanged) {
          emit(registerState.cloneAndUpdate(
              isValidEmail: Validators.isValidEmail(event.email)));
        } else if (event is RegisterEventPasswordChanged) {
          emit(registerState.cloneAndUpdate(
              isValidPassword: Validators.isValidEmail(event.password)));
        } else if (event is RegisterEventPressed) {
          emit(RegisterState.loading());
          try {
            await _userRepository.createUserWithEmailAndPassword(
                event.email, event.password);
            emit(RegisterState.success());
          } catch (_) {
            emit(RegisterState.failure());
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
