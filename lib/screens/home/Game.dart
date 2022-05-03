import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spy_project/models/customTimer.dart';
import 'package:spy_project/models/game.dart';
import 'package:spy_project/models/players.dart';
import 'package:spy_project/models/selectedFieldsList.dart';
import 'package:spy_project/shared/constants.dart';
enum types {  
  spy,
  citizen
}
class Game extends StatefulWidget {
  Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  int counter = 0;
  bool closed = true;
  @override
  Widget build(BuildContext context) {
  // final fields = Provider.of<SelectedFields>(context);
  // final players = Provider.of<Players>(context);
  final timer = Provider.of<CustomTimer>(context);
  final game = Provider.of<GameClass>(context);
  // var currentPlayrs = SplayTreeMap();

  // List<int> citizen = [];
  // List<int> spies = [];
  // for(int i=0; i < players.getCount;i++){
  //   citizen.add(i);
  // }
  // for(int i=0; i<players.getSpies; i++){
  //   final random = Random().nextInt(citizen.length);
  //   var temp = citizen[random];
  //   citizen.removeAt(random);
  //   spies.add(temp);
  // }
  // citizen.forEach((element) => currentPlayrs[element] = types.citizen);
  // spies.forEach((element) => currentPlayrs[element] = types.spy);

  //String? field = fields.getRandomField();
  // print('citizen = ${citizen.toString()} | spies = ${spies.toString()} | field = ${field}');
  // print('current players: ${currentPlayrs.entries}');

    return Scaffold(
      backgroundColor: secondaryDarkGreyColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            timer.cancel = true;
            Navigator.of(context).pop();
          },
        ), 
        title: Text("Game"),
        centerTitle: true,
        backgroundColor: mainDarkGreyColor,
      ),
      body: counter >= game.currentPlayers.length ? 
      Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: timer.getTime == 0 ? [
              Expanded(
                child: Center(
                  child: Text('Players ${Map.fromEntries(game.currentPlayers.entries.where((entry)=>entry.value==types.spy)).keys.map((e)=>e+1) } were spies',
                    style: TextStyle(color: accentRedColor, fontSize: 32),
                    textAlign: TextAlign.center
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child:ElevatedButton(
                style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15.0)),
                      alignment: Alignment.center,
                      backgroundColor: MaterialStateProperty.all<Color>(mainDarkGreyColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        side: BorderSide(width:2, color: accentRedColor),
                      )
                      )
                    ),
                    onPressed: (){
                      timer.cancel = true;
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: Text('Go back',  style: TextStyle(fontSize: 16,color: Colors.white)),
              )
              )
            ] : [
              Text('Let the game begin',
                style: TextStyle(color: accentRedColor, fontSize: 32),
                textAlign: TextAlign.center
              ),
              SizedBox(height: 50,),
              Text('${timer.getTime}',
                style: TextStyle(color: accentRedColor, fontSize: 32),
                textAlign: TextAlign.center
              )
            ]
          )
        ),
      ) 
      : 
      Container(padding: EdgeInsets.fromLTRB(50, 80, 50, 80),
        child: ElevatedButton(
          onPressed: () {
            if(counter==game.currentPlayers.length-1 && !closed){
              timer.start();
            }
            if(counter<game.currentPlayers.length){
              if(!closed){
                setState(() => counter++);
              }
              setState(()=> closed=!closed);
            }
            print(counter);  
          },
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(30.0)),
            alignment: Alignment.center,
            backgroundColor: MaterialStateProperty.all<Color>(mainDarkGreyColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
              side: BorderSide(width:2, color: game.currentPlayers[counter]==types.spy && !closed ? accentRedColor : Colors.white),
            )
            )
          ),
            child: Center(
              child: closed ? 
              Text('Player ${counter+1}',style: TextStyle(color: Colors.white, fontSize: 32), textAlign: TextAlign.center)
              : 
              Column(
                children: [
                  SizedBox(height: 50),
                  Expanded(
                    child: SizedBox(child: game.currentPlayers[counter]==types.spy ?
                      Text('Shhh... You are a spy', style: TextStyle(color: accentRedColor, fontSize: 24), textAlign: TextAlign.center) 
                      :
                      Text('${game.field}',style: TextStyle(color: Colors.white, fontSize: 24), textAlign: TextAlign.center),
                    ),
                  ),
                  SizedBox(height: 100),
                  SizedBox(height: 100, child: game.currentPlayers[counter]==types.spy ?
                    Text('Try to guess, what players are talking about. Ask questions and give answers carefully!',style: TextStyle(color: accentRedColor, fontSize: 16), textAlign: TextAlign.center) 
                    :
                    Text('You are citizen. All citizens know whai is this field. Ask questions and give answers about the field. Detect all spies and win!',style: TextStyle(color: Colors.white, fontSize: 16), textAlign: TextAlign.center,),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}