import 'dart:math';

import 'package:flutter/cupertino.dart';

class SelectedFields extends ChangeNotifier{
  // SelectedFields({required this._fields});
  List _fields=[];

  int get fieldsLength{
    return _fields.length;
  }
  String? getRandomField(){
    if(_fields.isNotEmpty){
      final random = Random().nextInt(_fields.length);
      return _fields[random];
    } else {
      return null;
    }
  }
  set fields(List fields){
    _fields = fields;
  }
  void addFields(List fields){
    _fields.addAll(fields);
    _fields = _fields.toSet().toList();
    notifyListeners();
  }
  void addField(String field){
    _fields.add(field);
    notifyListeners();
  }
  void removeFields(List fields){
    fields.forEach((element) {_fields.remove(element);});
    notifyListeners();
  }
  void removeField(String field){
    _fields.remove(field);
    notifyListeners();
  }
  void printFields(){
    print(_fields.toString());
  }
  bool includesEvery(List fields){
    if(_fields.toSet().containsAll(fields.toSet())){
      return true;
    }else{
      return false;
    }
  }
  int countMatches(List fields){
    return _fields.toSet().intersection(fields.toSet()).length;
  }
  bool includesAny(List fields){
    if(_fields.toSet().intersection(fields.toSet()).isNotEmpty){
      return true;
    }else{
      return false;
    }
  }
  bool includes(String field){
    if(_fields.contains(field)){
      return true;
    }
    else {
      return false;
    }
  }
}