import 'package:flutter/material.dart';

class DraggableWidget extends StatefulWidget{

  final String customWidgetString;
  final Key key;

  const DraggableWidget({this.key, this.customWidgetString}) : super(key: key);

  @override
  _DraggableWidgetState createState() => _DraggableWidgetState();
}



class _DraggableWidgetState extends State<DraggableWidget> {
  Widget _widget(context){
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        elevation: 5.0,
        child: Container(
          height: MediaQuery.of(context).size.height/5,
          width: MediaQuery.of(context).size.width/3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Colors.grey[900],
          ),
          child: ListTile(
            key: widget.key,
            title: Text(widget.customWidgetString,
            style: TextStyle(
              fontFamily: 'FiraSansExtraCondensed',
              color: Colors.white,
              fontSize: 18.0
            ),),

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
