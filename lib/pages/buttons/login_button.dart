import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  VoidCallback? _voidCallback;
  LoginButton({super.key, VoidCallback? onPressed}) : _voidCallback = onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        height: 45,
        child: InkWell(
            onTap: _voidCallback,
            child: Container(
              height: 45,
              decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: const Center(
                child: Text(
                  "Login to your account",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            )));
  }
}
