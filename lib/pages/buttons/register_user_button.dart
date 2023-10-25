import 'package:firebase_login_bloc/blocs/register_bloc.dart';
import 'package:firebase_login_bloc/pages/register_page.dart';
import 'package:firebase_login_bloc/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterUserButton extends StatelessWidget {
  final UserRepository _userRepository;
  const RegisterUserButton({super.key, required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        height: 45,
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return BlocProvider(
                  create: (context) =>
                      RegisterBloc(userRepository: _userRepository),
                  child: RegisterPage(userRepository: _userRepository),
                );
              }));
            },
            child: Container(
              height: 45,
              decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: const Center(
                child: Text(
                  "Register a new account",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            )));
  }
}
