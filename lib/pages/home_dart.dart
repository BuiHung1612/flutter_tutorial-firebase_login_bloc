import 'package:firebase_login_bloc/blocs/authentication_bloc.dart';
import 'package:firebase_login_bloc/events/authentication_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationEventLoggedOut());
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: const Center(
          child: Text(
        "This is HomePage",
        style: TextStyle(fontSize: 22),
      )),
    );
  }
}
