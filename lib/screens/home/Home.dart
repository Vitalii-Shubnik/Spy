import 'dart:collection';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spy_project/models/customTimer.dart';
import 'package:spy_project/models/game.dart';
import 'package:spy_project/models/players.dart';
import 'package:spy_project/models/selectedFieldsList.dart';
import 'package:spy_project/screens/home/Game.dart';
import 'package:spy_project/screens/home/PlayersAlert.dart';
import 'package:spy_project/screens/home/TimersetAlert.dart';
import 'package:spy_project/services/auth.dart';
import 'package:spy_project/services/database.dart';
import 'package:spy_project/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:spy_project/screens/home/CategoryList.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();
  //var categories = DatabaseService().getCategories();
  @override
  Widget build(BuildContext context) {
    final timer = Provider.of<CustomTimer>(context);
    final user = context.watch<User>();
    final fields = Provider.of<SelectedFields>(context);
    final players = Provider.of<Players>(context);
    final game = Provider.of<GameClass>(context);
    return 
    // StreamProvider<QuerySnapshot<Map<String,dynamic>>?>(
    //   initialData: null,
    //   create: () => DatabaseService().categoriesStream,
    //   child: 
          Scaffold(
          backgroundColor: secondaryDarkGreyColor,
          appBar: AppBar(
            title: Text('Spy'),
            backgroundColor: mainDarkGreyColor,
            elevation: 0.0,
            actions: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.person, color: Colors.white,),
                label: Text('logout', style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  _auth.signOut();
                },
              )
            ],
          ),
          body: 
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Center(
                child: Column(
                  children:<Widget>[ Expanded(
                    child: Column(
                      children: <Widget>[ 
                        
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: mainButtonStyle,
                            onPressed: () {
                              Navigator.pushNamed(context, "/categories", arguments: "1");
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(  
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text('Select categories', style: TextStyle(fontSize: 16,color: Colors.white)),
                                  Text("${fields.fieldsLength}", style: TextStyle(fontSize: 16,color: accentRedColor)),
                              ]
                              ),
                            )
                            
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: mainButtonStyle,
                            onPressed: () {
                              setTimerDialog(context);
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(  
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text('Timer', style: TextStyle(fontSize: 16,color: Colors.white)),
                                  Text("${timer.getTime.toString()} seconds", style: TextStyle(fontSize: 16,color: accentRedColor)),
                              ]
                              ),
                            )
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: mainButtonStyle,
                            onPressed: () {
                              setPlayersDialog(context);
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(  
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Players ', style: TextStyle(fontSize: 16,color: Colors.white)),
                                  Text('${players.getCount.toString()} | ${players.getSpies.toString()}', style: TextStyle(fontSize: 16,color: accentRedColor))
                              ]
                              ),
                            )
                            //child: const Text('Players',  style: TextStyle(fontSize: 16,color: Colors.white)),
                          ),
                        ),
                      ]
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: mainRedButtonStyle,
                      onPressed: () {
                        var currentPlayrs = SplayTreeMap();
                        List<int> citizen = [];
                        List<int> spies = [];
                        for(int i=0; i < players.getCount;i++){
                          citizen.add(i);
                        }
                        for(int i=0; i<players.getSpies; i++){
                          final random = Random().nextInt(citizen.length);
                          var temp = citizen[random];
                          citizen.removeAt(random);
                          spies.add(temp);
                        }
                        citizen.forEach((element) => currentPlayrs[element] = types.citizen);
                        spies.forEach((element) => currentPlayrs[element] = types.spy);
                        
                        game.field = fields.getRandomField();
                        game.currentPlayers = currentPlayrs;
                          print('citizen = ${citizen.toString()} | spies = ${spies.toString()} | field = ${game.field}');
                          print('current players: ${game.currentPlayers.entries}');
                        if(fields.fieldsLength>0 && timer.getTime>0)
                          Navigator.pushNamed(context, "/game", arguments: "1");
                      },
                      child: const Text('Start Game',  style: TextStyle(fontSize: 16,color: Colors.white)),
                    ),
                  ),
                  ]
                ),
              ),
            )
          // body: Container( // Handle your callback
          //   padding: EdgeInsets.symmetric(horizontal: 10.0),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: <Widget>[
          //       Ink(
          //           height: 50,
          //           width: MediaQuery.of(context).size.width,
          //           decoration: BoxDecoration(
          //             border: Border.all(color: secondaryGreyColor, width: 2),
          //             borderRadius: BorderRadius.circular(5),
          //             color: mainDarkGreyColor
          //           ),
          //           child: InkWell(
          //             onTap: () {
                        
          //             },
          //             child: Container(
          //               alignment: Alignment.center, 
          //               child: Text('hello',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
          //           ),
          //         ),
          //       ),
                
          //       Text('2')
          //     ]
          //   ),
          // ),
      );
  }
}