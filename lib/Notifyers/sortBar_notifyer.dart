import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonbarColor extends ChangeNotifier{
  var _color1 = new List();
  var _color2 = new List();
  var _color3 = new List();
  var _color4 = new List();
  bool _firstCall = false;
  final context;
  int _index = 0;

  ButtonbarColor({@required this.context});

  get index {
    return _index;
  }

  get buttonColor1 {
    if (_firstCall == false) {
      return [Color.fromRGBO(19, 19, 19, 40), Color.fromRGBO(10, 10, 10, 1.0), Color.fromRGBO(40, 40, 40, 1.0)];
    }
    return _color1;
  }

  get buttonColor2 {
    if (_firstCall == false) {
      return [Color.fromRGBO(19, 19, 19, 40), Color.fromRGBO(10, 10, 10, 1.0), Color.fromRGBO(40, 40, 40, 1.0)];
    }
    return _color2;
  }

  get buttonColor3 {
    if (_firstCall == false) {
      return [Color.fromRGBO(19, 19, 19, 40), Color.fromRGBO(10, 10, 10, 1.0), Color.fromRGBO(40, 40, 40, 1.0)];
    }
    return _color3;
  }

  get buttonColor4 {
    if (_firstCall == false) {
      return [Color.fromRGBO(19, 19, 19, 40), Color.fromRGBO(10, 10, 10, 1.0), Color.fromRGBO(40, 40, 40, 1.0)];
    }
    return _color4;
  }

  updateButtonColor(int index, context) {
    if (index == 0) {
      _index = index;
      _firstCall = true;
      _color1 = [Color.fromRGBO(19, 19, 19, 40), Color.fromRGBO(40, 40, 40, 40), Color.fromRGBO(10, 10, 10, 1.0)];
      _color2 = [Color.fromRGBO(19, 19, 19, 40), Color.fromRGBO(10, 10, 10, 1.0), Color.fromRGBO(40, 40, 40, 1.0)];
      _color3 = [Color.fromRGBO(19, 19, 19, 40), Color.fromRGBO(10, 10, 10, 1.0), Color.fromRGBO(40, 40, 40, 1.0)];
      _color4 = [Color.fromRGBO(19, 19, 19, 40), Color.fromRGBO(10, 10, 10, 1.0), Color.fromRGBO(40, 40, 40, 1.0)];
    }
    else if (index == 1) {
      _index = index;
      _firstCall = true;
      _color1 = [Color.fromRGBO(19, 19, 19, 40), Color.fromRGBO(10, 10, 10, 1.0), Color.fromRGBO(40, 40, 40, 1.0)];
      _color2 = [Color.fromRGBO(19, 19, 19, 40), Color.fromRGBO(40, 40, 40, 1.0), Color.fromRGBO(10, 10, 10, 1.0)];
      _color3 = [Color.fromRGBO(19, 19, 19, 40), Color.fromRGBO(10, 10, 10, 1.0), Color.fromRGBO(40, 40, 40, 1.0)];
      _color4 = [Color.fromRGBO(19, 19, 19, 40), Color.fromRGBO(10, 10, 10, 1.0), Color.fromRGBO(40, 40, 40, 1.0)];
    }
    else if (index == 2) {
      _index = index;
      _firstCall = true;
      _color1 = [Color.fromRGBO(19, 19, 19, 40), Color.fromRGBO(10, 10, 10, 1.0), Color.fromRGBO(40, 40, 40, 1.0)];
      _color2 = [Color.fromRGBO(19, 19, 19, 40), Color.fromRGBO(10, 10, 10, 1.0), Color.fromRGBO(40, 40, 40, 1.0)];
      _color3 = [Color.fromRGBO(19, 19, 19, 40), Color.fromRGBO(40, 40, 40, 1.0), Color.fromRGBO(10, 10, 10, 1.0)];
      _color4 = [Color.fromRGBO(19, 19, 19, 40), Color.fromRGBO(10, 10, 10, 1.0), Color.fromRGBO(40, 40, 40, 1.0)];
    }
    else if (index == 3) {
      _index = index;
      _firstCall = true;
      _color1 = [Color.fromRGBO(19, 19, 19, 40), Color.fromRGBO(10, 10, 10, 1.0), Color.fromRGBO(40, 40, 40, 1.0)];
      _color2 = [Color.fromRGBO(19, 19, 19, 40), Color.fromRGBO(10, 10, 10, 1.0), Color.fromRGBO(40, 40, 40, 1.0)];
      _color3 = [Color.fromRGBO(19, 19, 19, 40), Color.fromRGBO(10, 10, 10, 1.0), Color.fromRGBO(40, 40, 40, 1.0)];
      _color4 = [Color.fromRGBO(19, 19, 19, 40), Color.fromRGBO(40, 40, 40, 1.0), Color.fromRGBO(10, 10, 10, 1.0)];
    }
    notifyListeners();
  }
}