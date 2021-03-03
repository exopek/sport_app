import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListViewIndex extends ChangeNotifier {
   var _favoriteIndex;
   final context;

  ListViewIndex({@required this.context});

  get favoriteIndex {
    if (_favoriteIndex == null) {
      return _favoriteIndex = 0;
    } else {
      return _favoriteIndex;
    }

  }

  updateIndex(int Index, context) {
    _favoriteIndex = Index;
    notifyListeners();
  }
}