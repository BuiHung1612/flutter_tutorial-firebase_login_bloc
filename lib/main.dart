import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login_bloc/blocs/authentication_bloc.dart';
import 'package:firebase_login_bloc/blocs/login_bloc.dart';
import 'package:firebase_login_bloc/blocs/simple_bloc_observer.dart';
import 'package:firebase_login_bloc/events/authentication_event.dart';
import 'package:firebase_login_bloc/pages/home_dart.dart';
import 'package:firebase_login_bloc/pages/login_page.dart';
import 'package:firebase_login_bloc/pages/splash_page.dart';
import 'package:firebase_login_bloc/repositories/user_repository.dart';
import 'package:firebase_login_bloc/states/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _userRepository = UserRepository();

    return MaterialApp(
        title: 'Login with firebase',
        home: BlocProvider(
          create: (context) {
            return AuthenticationBloc(userRepository: _userRepository)
              ..add(AuthenticationEventStarted());
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationStateSuccess) {
                return const HomePage();
              } else if (state is AuthenticationStateFailure) {
                return BlocProvider<LoginBloc>(
                  create: (context) =>
                      LoginBloc(userRepository: _userRepository),
                  child: LoginPage(userRepository: _userRepository),
                );
              }
              // return const SplashPage();
              return BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(userRepository: _userRepository),
                child: LoginPage(userRepository: _userRepository),
              );
            },
          ),
        ));
  }
}
