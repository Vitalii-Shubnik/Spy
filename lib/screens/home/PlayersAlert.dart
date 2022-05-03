import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spy_project/models/players.dart';
import 'package:spy_project/shared/constants.dart';

Future setPlayersDialog(BuildContext context ) async {
  final players = Provider.of<Players>(context, listen: false);
  int count = 3;
  int spies = 1;
  return showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        titleTextStyle: TextStyle(color: accentRedColor, fontSize: 24),
        shape:
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
            side: BorderSide(width:2, color: accentRedColor),
          ),
        backgroundColor: secondaryGreyColor,
        title: Text('How many players?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Expanded(
            //   child:
              Text('At least 2 players must be NOT spies'),
              SizedBox(height: 40,),
              TextField(
                style: TextStyle(fontSize: 18),
                maxLength: 2,
                autofocus: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: accentRedColor, width: 2)),
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: 'All players', 
                  hintText: 'Enter count',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                
                onChanged: (value) {
                  if(int.tryParse(value)!=null){
                    count = int.parse(value);
                  }
                 
                },
              ),
              SizedBox(height: 10,),
            // ),
            TextField(
                style: TextStyle(fontSize: 18),
                maxLength: 1,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Spies', 
                  hintText: 'Enter count',
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
                    spies = int.parse(value);
                  }
                 
                },
              )
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(secondaryDarkGreyColor),),
            child: const Text('Ok'),
            onPressed: () {
              if(count>=spies+2)
              {
                if(count>=3 && count<=12){
                  players.setCount = count;    
                }else{
                  players.setCount = 12;
                }

                if(spies>=1 && spies<=4){
                  players.setSpies = spies;
                }else{
                  players.setSpies = 1;
                }
                
              }
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