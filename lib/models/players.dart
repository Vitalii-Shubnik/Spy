import 'package:flutter/material.dart';

class Players extends ChangeNotifier{
  int _count = 3;
  int _spies = 1;

  int get getSpies{
    return _spies;
  }
  int get getCount{
    return _count;
  }

  set setSpies(int spies){
    _spies = spies;
    notifyListeners();
  }
  set setCount(int count){
    _count = count;
    notifyListeners();
  }

}