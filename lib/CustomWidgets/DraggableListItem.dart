import 'package:flutter/material.dart';

class DraggableWidget extends StatelessWidget{

  final String customWidgetString;
  final Key key;

  const DraggableWidget({this.key, this.customWidgetString}) : super(key: key);

  Widget _widget(context){
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        elevation: 5.0,
        child: Container(
          height: MediaQuery.of(context).size.height/6,
          width: MediaQuery.of(context).size.width/3,
          child: ListTile(
            key: key,
            title: Text(customWidgetString),

          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return _widget(context);
  }
}
