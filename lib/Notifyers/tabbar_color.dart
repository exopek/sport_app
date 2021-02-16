import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabbarColor extends ChangeNotifier{
  var _color1 = new List();
  var _color2 = new List();
  bool _firstCall = false;
  final context;

  TabbarColor({@required this.context});

   get tabColor1 {
     if (_firstCall == false) {
       return [Colors.grey[800], Colors.blueGrey, Colors.blueGrey[200]];
     }
    return _color1;
  }

   get tabColor2 {
     if (_firstCall == false) {
       return [Colors.black, Colors.black, Colors.black];
     }
    return _color2;
  }

  updateTabColor(int index, context) {
    if (index == 0) {
      _firstCall = true;
      _color1 = [Colors.black54, Colors.black87, Colors.white24];
      _color2 = [Colors.transparent, Colors.transparent, Colors.transparent];
    }
    else if (index == 1) {
      _firstCall = true;
      _color1 = [Colors.transparent, Colors.transparent, Colors.transparent];
      _color2 = [Colors.grey[800], Colors.blueGrey, Colors.blueGrey[200]];
    }
    notifyListeners();
  }
}