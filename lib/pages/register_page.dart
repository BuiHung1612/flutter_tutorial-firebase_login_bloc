import 'dart:developer';

import 'package:firebase_login_bloc/blocs/register_bloc.dart';
import 'package:firebase_login_bloc/events/register_event.dart';
import 'package:firebase_login_bloc/pages/buttons/register_button.dart';
import 'package:firebase_login_bloc/repositories/user_repository.dart';
import 'package:firebase_login_bloc/states/register_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc.dart';
import '../events/authentication_event.dart';

class RegisterPage extends StatefulWidget {
  final UserRepository _userRepository;
  RegisterPage({super.key, required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  RegisterBloc? _registerBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  bool isRegisterButtonEnabled(RegisterState registerState) {
    return isPopulated &&
        registerState.isValidEmailAndPassword &&
        !registerState.isSubmitting;
  }

  UserRepository get _userRepository => widget._userRepository;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
        if (state.isFailure) {
          log('registration failed');
        } else if (state.isSubmitting) {
          log('registration In');
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
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: RegisterButton(onPressed: () {
                  if (isRegisterButtonEnabled(state)) {
                    _registerBloc?.add(RegisterEventPressed(
                        email: _emailController.text,
                        password: _passwordController.text));
                  }
                }),
              )
            ],
          )),
        );
      }),
    );
  }
}
