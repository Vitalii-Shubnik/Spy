import 'package:flutter/material.dart';

class GameClass extends ChangeNotifier{
  Map _currentPlayers ={};
  String? _field = null;
  
  Map get currentPlayers{
    return _currentPlayers;
  }
  String? get field{
    return _field;
  }

  set currentPlayers(Map currentPlayers){
    _currentPlayers = currentPlayers;
    notifyListeners();
  }
  set field(String? field){
    _field = field;
    notifyListeners();
  }

}