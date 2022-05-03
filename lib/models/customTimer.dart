import 'dart:async';

import 'package:flutter/material.dart';

class CustomTimer extends ChangeNotifier{
  int _time = 120;

  bool _cancel = false;

  int get getTime {
    return _time;
  }

  set cancel(bool cancel){
    _cancel = cancel;
  }
  
  set setTime(int seconds) {
    _time = seconds;
    notifyListeners();
  }
  
  void start(){
    cancel=false;
    Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(_time>0 && !_cancel){
        _time--;
      } else {
        timer.cancel();
      }
      notifyListeners();
     });
  }
}