import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../blocs/login_bloc.dart';
import '../../events/login_event.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        height: 45,
        child: InkWell(
            onTap: () {
              BlocProvider.of<LoginBloc>(context)
                  .add(LoginEventWithGooglePressed());
            },
            child: Container(
              height: 45,
              decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.google,
                    color: Colors.white,
                    size: 17,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Signin with Google',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )
                ],
              ),
            )));
  }
}
