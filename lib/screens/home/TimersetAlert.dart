import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spy_project/models/customTimer.dart';
import 'package:spy_project/services/database.dart';
import 'package:spy_project/shared/constants.dart';

Future setTimerDialog(BuildContext context ) async {
  final timer = Provider.of<CustomTimer>(context, listen: false);
  int time = 120;
  return showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        titleTextStyle: TextStyle(color: accentRedColor, fontSize: 24),
        contentTextStyle: TextStyle(color: accentRedColor, fontSize: 16),
        shape:
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
            side: BorderSide(width:2, color: accentRedColor),
          ),
        backgroundColor: secondaryGreyColor,
        title: Text('Timer'),
        content: Row(
          children: <Widget>[
            Expanded(
              child:TextField(
                maxLength: 3,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Time',
                  hintText: 'Enter time in seconds',
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: accentRedColor, width: 2)),
                  labelStyle: TextStyle(color: Colors.white),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: (value) {
                  if(int.tryParse(value)!=null){
                    time = int.parse(value);
                  }
                },
              )
            )
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(secondaryDarkGreyColor),),
            child: const Text('Ok'),
            onPressed: () {
              if(time>0){
                timer.setTime = time;    
                Navigator.of(context, rootNavigator: true).pop();
              }
            },
          ),
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(secondaryDarkGreyColor),),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
      );
    },
  );
}