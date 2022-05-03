import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:spy_project/shared/constants.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 18, 18, 18),
      child: Center(
        child: SpinKitFadingCircle(
          color: accentRedColor,
          size: 50,
        ),
      ),
    );
  }
}