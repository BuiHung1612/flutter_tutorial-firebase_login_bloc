import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class LoginEventEmailChanged extends LoginEvent {
  final String email;
  const LoginEventEmailChanged({required this.email});

  @override
  List<Object?> get props => [email];
  @override
  String toString() {
    return 'email changed:$email';
  }
}

class LoginEventPasswordChanged extends LoginEvent {
  final String password;
  const LoginEventPasswordChanged({required this.password});

  @override
  List<Object?> get props => [password];
  @override
  String toString() {
    return 'password changed:$password';
  }
}

class LoginEventWithGooglePressed extends LoginEvent {}

class LoginEventWithEmailAndPasswordPressed extends LoginEvent {
  final String email;
  final String password;
  const LoginEventWithEmailAndPasswordPressed(
      {required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
  @override
  String toString() {
    return 'LoginEventWithEmailAndPasswordPressed email:$email, password:$password';
  }
}
