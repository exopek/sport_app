import 'package:flutter/cupertino.dart';

class TagList extends ChangeNotifier {

  var _tagList = new List();

  get list_tags {
    return _tagList;
  }

  updateListTags(List tags) {
    _tagList = tags;
    notifyListeners();
  }

}