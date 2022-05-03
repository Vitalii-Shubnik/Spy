import 'package:flutter/material.dart';

const textInputStyle = TextStyle(color: Color.fromARGB(255, 109, 13, 13));

const mainDarkGreyColor = Color.fromARGB(255, 27, 27, 27);
const secondaryDarkGreyColor = Color.fromARGB(233, 47, 47, 47);
const accentRedColor = Color.fromARGB(255, 184, 21, 21);
const secondaryGreyColor = Color.fromARGB(255, 66, 66, 66);

const textInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
  hintStyle: TextStyle(color: accentRedColor),
  filled: true,
  fillColor: (Color.fromARGB(255, 28, 28, 28)),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: (secondaryGreyColor), width: 2.0)
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
      BorderSide(
        color: (accentRedColor), 
        width: 2.0
      )
  )
);

final mainButtonStyle = ButtonStyle(
  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15.0)),
  alignment: Alignment.center,
  backgroundColor: MaterialStateProperty.all<Color>(secondaryDarkGreyColor),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.0),
      side: BorderSide(width:2, color: Colors.white),
    )
  )
);

final mainRedButtonStyle = ButtonStyle(
  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15.0)),
  alignment: Alignment.center,
  backgroundColor: MaterialStateProperty.all<Color>(mainDarkGreyColor),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.0),
      side: BorderSide(width:2, color: accentRedColor),
    )
  )
);