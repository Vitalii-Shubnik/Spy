import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spy_project/models/myCategory.dart';
import 'package:spy_project/services/database.dart';
import 'package:spy_project/shared/constants.dart';


// class NewCategoryAlert extends StatefulWidget {
//   NewCategoryAlert({Key? key}) : super(key: key);

//   @override
//   State<NewCategoryAlert> createState() => _NewCategoryAlertState();
// }

// class _NewCategoryAlertState extends State<NewCategoryAlert> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

Future newCategoryDialog(BuildContext context, String userid) async {
  //final user = context.watch<User>();
  String name = '';
  return showDialog(
    context: context,
    barrierDismissible: false, // dialog is dismissible with a tap on the barrier
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
        title: Text('New Category'),
        content: Row(
          children: <Widget>[
            Expanded(
                child:TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Add category', 
                    hintText: 'Enter category name',
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: accentRedColor, width: 2)),
                  labelStyle: TextStyle(color: Colors.white),
                    ),
                  onChanged: (value) {
                    name = value;
                  },
                ))
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(secondaryDarkGreyColor),),
            child: const Text('Ok'),
            onPressed: () async{
              dynamic docRef = await DatabaseService().addCategory(MyCategory(fields: [], free: true, name: name, postedBy: userid));
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