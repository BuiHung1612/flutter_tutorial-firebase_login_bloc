import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  VoidCallback? _voidCallback;
  RegisterButton({super.key, VoidCallback? onPressed})
      : _voidCallback = onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        height: 45,
        child: InkWell(
            onTap: () {
              if (_voidCallback != null) {
                _voidCallback!();
                Navigator.of(context).pop();
              }
            },
            child: Container(
              height: 45,
              decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: const Center(
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            )));
  }
}
