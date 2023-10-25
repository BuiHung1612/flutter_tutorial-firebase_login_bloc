import 'package:firebase_login_bloc/events/authentication_event.dart';
import 'package:firebase_login_bloc/repositories/user_repository.dart';
import 'package:firebase_login_bloc/states/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  AuthenticationBloc({required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(AuthenticationStateInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is AuthenticationEventStarted) {
        final isSignedIn = await _userRepository.isSignedIn();
        if (isSignedIn) {
          await _userRepository.getUser().then((value) => {
                if (value != null)
                  {emit(AuthenticationStateSuccess(firebaseUser: value))}
                else
                  {emit(AuthenticationStateFailure())}
              });
        }
      } else if (event is AuthenticationEventLoggedIn) {
        emit(AuthenticationStateSuccess(
            firebaseUser: await _userRepository.getUser()));
      } else if (event is AuthenticationEventLoggedOut) {
        _userRepository.signOut();
        emit(AuthenticationStateFailure());
      }
    });
  }
}
