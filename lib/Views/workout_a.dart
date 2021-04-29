import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_app/Views/videoPlayer_withListView.dart';

import '../videoplayerservice.dart';

class WorkoutAPage extends StatelessWidget {

  final thumbnail;
  final String workoutName;
  final String videoUrl;

  const WorkoutAPage({Key key, this.thumbnail, this.workoutName, this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
                child: _header(context)),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/15, top: MediaQuery.of(context).size.height/18),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('Übersicht',
                  style: TextStyle(
                      fontFamily: 'FiraSansExtraCondensed',
                      fontSize: 25.0,
                      color: Colors.white
                  ),
                ),
              ),
            ),
            _overview(context),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
              child: Align(
                alignment: Alignment.bottomCenter,
                  child: _startButton(context)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35.0), bottomRight: Radius.circular(35.0)),
      child: Container(
        height: MediaQuery.of(context).size.height/2.6,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Material(
              elevation: 5.0,
              shadowColor: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35.0), bottomRight: Radius.circular(35.0)),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.modulate),
                child: Container(
                  height: MediaQuery.of(context).size.height/2.6,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(35.0), bottomLeft: Radius.circular(35.0)),
                    image: DecorationImage(
                      image: NetworkImage(thumbnail),
                      fit: BoxFit.fill
                    ),
                  ),
                ),
              )
          ),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/15),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(workoutName.toUpperCase(),
                  style: TextStyle(
                      fontFamily: 'FiraSansExtraCondensed',
                      fontSize: 30.0,
                      color: Colors.black
                  ),
                ),
              ),
            ),
        ]
        ),
      ),
    );
  }

  Widget _overview(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Divider(
            thickness: 0.2,
            color: Colors.grey[200],
          ),
          Text(workoutName.toUpperCase(),
            style: TextStyle(
                fontFamily: 'FiraSansExtraCondensed',
                fontSize: 20.0,
                color: Colors.white
            ),
          ),
          Divider(
            thickness: 0.2,
            color: Colors.grey[200],
          ),
        ],
      ),
    );
  }

  Widget _startButton(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(35.0),
      elevation: 5.0,
      child: Container(
        height: MediaQuery.of(context).size.height/10,
        width: MediaQuery.of(context).size.width/2,
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return VideoPlayerList(urlList: [videoUrl]);
              },
            ),
          ),
          child: Center(
            child: Text('Start'.toUpperCase(),
            style: TextStyle(
              fontFamily: 'FiraSansExtraCondensed',
              color: Colors.black
            ),),
          ),
        ),
      ),
    );
  }

}
