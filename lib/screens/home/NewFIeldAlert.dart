import 'package:flutter/material.dart';
import 'package:spy_project/models/myCategory.dart';
import 'package:spy_project/services/database.dart';
import 'package:spy_project/shared/constants.dart';

Future newFieldDialog(BuildContext context, String docId ) async {
  String name = '';
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
        title: Text('Add field'),
        content: Row(
          children: <Widget>[
            Expanded(
              child:TextField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Field name',
                  hintText: 'Enter field',
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: accentRedColor, width: 2)),
                  labelStyle: TextStyle(color: Colors.white),
                  ),
                onChanged: (value) {
                  name = value;
                },
              )
            )
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(secondaryDarkGreyColor),),
            child: const Text('Ok'),
            onPressed: () async {
              dynamic docRef = await DatabaseService().addFieldToCategory(name, docId);
              Navigator.of(context, rootNavigator: true).pop();
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