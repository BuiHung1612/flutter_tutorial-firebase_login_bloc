import 'dart:developer';

import 'package:firebase_login_bloc/blocs/authentication_bloc.dart';
import 'package:firebase_login_bloc/blocs/login_bloc.dart';
import 'package:firebase_login_bloc/events/authentication_event.dart';
import 'package:firebase_login_bloc/events/login_event.dart';
import 'package:firebase_login_bloc/pages/buttons/google_button_login.dart';
import 'package:firebase_login_bloc/pages/buttons/login_button.dart';
import 'package:firebase_login_bloc/pages/buttons/register_user_button.dart';
import 'package:firebase_login_bloc/repositories/user_repository.dart';
import 'package:firebase_login_bloc/states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final UserRepository _userRepository;
  LoginPage({super.key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginBloc? _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(() {
      _loginBloc!.add(LoginEventEmailChanged(email: _emailController.text));
    });
    _passwordController.addListener(() {
      _loginBloc!
          .add(LoginEventPasswordChanged(password: _passwordController.text));
    });
  }

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  bool isLoginButtonEnabled(LoginState loginState) {
    return isPopulated &&
        loginState.isValidEmailAndPassword &&
        !loginState.isSubmitting;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state.isFailure) {
          log('Login failed');
        } else if (state.isSubmitting) {
          log('Logged In');
        } else if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationEventLoggedIn());
        }

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
              child: ListView(
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.always,
                autocorrect: false,
                validator: (value) {
                  return state.isValidEmail ? null : 'Invalid email format';
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.email), labelText: "Enter your email"),
              ),
              TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.always,
                autocorrect: false,
                validator: (value) {
                  return state.isValidPassword
                      ? null
                      : 'Invalid password format';
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.lock), labelText: "Enter your password"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 5),
                child: LoginButton(
                    onPressed: isLoginButtonEnabled(state)
                        ? _onLoginEmailAndPassword
                        : null),
              ),
              RegisterUserButton(userRepository: _userRepository),
              const SizedBox(
                height: 5,
              ),
              const GoogleLoginButton()
            ],
          )),
        );
      }),
    );
  }

  void _onLoginEmailAndPassword() {
    _loginBloc?.add(LoginEventWithEmailAndPasswordPressed(
        email: _emailController.text, password: _passwordController.text));
    //Failed because user does not exist
  }
}
