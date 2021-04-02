import 'package:flutter/cupertino.dart';

class TextRoutine extends ChangeNotifier  {

  int _index = 0;

  get index {
    return _index;
  }

  updateListTags(int pageViewIndex) {
    _index = pageViewIndex;
    notifyListeners();
  }

}