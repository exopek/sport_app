import 'package:flutter/cupertino.dart';

class TimerNotifyer extends ChangeNotifier {


  int _newIndex = 0;

  get index {
    return _newIndex;
  }

  void update(int oldIndex) {
    _newIndex = oldIndex + 1;
    notifyListeners();
  }

}