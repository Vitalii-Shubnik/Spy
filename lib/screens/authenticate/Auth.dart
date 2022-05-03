import 'package:flutter/material.dart';
import 'package:spy_project/screens/authenticate/register.dart';
import 'package:spy_project/screens/authenticate/sign_in.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool isSignIn = true;

  void toggleSignType() {
    setState(() {
      isSignIn = !isSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSignIn) {
      return Container(
        child: SignIn(key: UniqueKey(), toggleSignType: toggleSignType),
      );
    } else {
      return Container(
        child: Register(key: UniqueKey(), toggleSignType: toggleSignType),
      );
    }
  }
}
