import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_app/CustomWidgets/halber_kreis.dart';
import 'package:circle_wheel_scroll/circle_wheel_scroll_view.dart';
import 'package:video_app/Notifyers/tag_notifyer.dart';


class MuskelPage extends StatefulWidget {

  @override
  _MuskelPageState createState() => _MuskelPageState();
}

class _MuskelPageState extends State<MuskelPage> {
  StreamController tagName;

  List tagNames = [];

  List iconList = [
    Icons.storage,
    Icons.language_outlined,
    Icons.camera,
    Icons.account_balance_sharp,
    Icons.image,
    Icons.adb_outlined,
    Icons.alarm_add_outlined,
  ];

  List itemNames = [
    'Brust',
    'Rücken',
    'Beine',
    'Schultern',
    'Arme',
    'Oberkörper',
    'Unterkörper'
  ];

  void initState() {
    tagName = StreamController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Stream indexListStream = tagName.stream;
    final TagList tags = Provider.of<TagList>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(19, 19, 19, 1.0),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add),
            label: Text('Sortieren')),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children:[
                // text mit dem stream als wert
                CustomPaint(
                  size: Size.infinite,
                  painter: ShapePainter(),
              ),
                CircleListScrollView(
                    itemExtent:140.0,
                    physics: CircleFixedExtentScrollPhysics(),
                    children: List.generate(7, _buildItem),
                    onSelectedItemChanged: (int index) => tagName.add(index), //stream
                    radius: MediaQuery.of(context).size.width*0.58,
                ),
                StreamBuilder(
                    stream: indexListStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.3, left: MediaQuery.of(context).size.width/1.5),
                          child: Text(itemNames[snapshot.data],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0
                          ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/2, left: MediaQuery.of(context).size.width/1.7),
                          child: Text(''),
                        );
                      }

                    })
            ]
            )
          ),
        ),
      )
    );
  }

  Widget _buildItem(int i) {
      return Padding(
        padding: EdgeInsets.all(30.0),
        child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40.0),
              child: GestureDetector(
                onTap: () {
                  //tagNames.add(value);
                },
                child: Container(
                  width: 80.0,
                  color: Colors.white,
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                      child: Icon(iconList[i])
                  ),
                ),
              ),
            )
        ),
      );

  }
}
