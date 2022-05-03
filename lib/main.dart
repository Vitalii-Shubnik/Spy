import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:spy_project/models/customTimer.dart';
import 'package:spy_project/models/game.dart';
import 'package:spy_project/models/myCategory.dart';
import 'package:spy_project/models/players.dart';
import 'package:spy_project/models/selectedFieldsList.dart';
import 'package:spy_project/screens/home/CategoryList.dart';
import 'package:spy_project/screens/home/Game.dart';
import 'package:spy_project/screens/wrapper.dart';
import 'package:spy_project/services/auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
Map<String, WidgetBuilder> routes = {
  "/": (context) => Wrapper(key: UniqueKey()),
  "/categories": (context) => CategoryList(key: UniqueKey()),
  "/game": (context) => Game(),
};
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(
          value: AuthService().onUserChanged(),
          initialData: null,
        ),
        ChangeNotifierProvider(create: (context)=>SelectedFields()),
        ChangeNotifierProvider(create: (context)=>CustomTimer()),
        ChangeNotifierProvider(create: (context)=>Players()),
        ChangeNotifierProvider(create: (context)=>GameClass())
      ],
      child: MaterialApp(
        initialRoute: '/',
        //home:Wrapper(key: UniqueKey()),
        routes: routes
      ),
    );
    // return StreamProvider<User?>.value(
    //   value: AuthService().onUserChanged(),
    //   initialData: null,
    //   child: MaterialApp(
    //     initialRoute: '/',
    //     //home:Wrapper(key: UniqueKey()),
    //     routes: routes
    //   ),
    // );
  }
}

