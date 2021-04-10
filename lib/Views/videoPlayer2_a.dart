import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class SamplePlayer2 extends StatefulWidget {
  final List videourl;
  SamplePlayer2({Key key, @required this.videourl}) : super(key: key);

  @override
  _SamplePlayer2State createState() => _SamplePlayer2State();
}

class _SamplePlayer2State extends State<SamplePlayer2> {
  FlickManager flickManager;

  String _videoUrl;

  int _currentIndex;

  @override
  void initState() {
    super.initState();
    print('drin');
    _currentIndex = 0;
    _videoUrl = widget.videourl[0];
    print(_videoUrl);
    flickManager = FlickManager(
        autoPlay: true,
        videoPlayerController:
        VideoPlayerController.network(_videoUrl)

    );
  }


  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }



  void timer() {
    Timer(Duration(seconds: 8) , () {
      setState(() {
        if (_currentIndex <= widget.videourl.length) {
          _currentIndex += 1;
          _videoUrl = widget.videourl[_currentIndex];
          flickManager = FlickManager(
              autoPlay: true,
              videoPlayerController:
              VideoPlayerController.network(_videoUrl));
          // ToDo: Timer Liste kommt hier noch hin
          print('currentIndex: $_currentIndex');
        } else {
          // ToDo: PageRoute,das Workout ist beendet
        }

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    timer();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height,
            flexibleSpace: FlexibleSpaceBarSettings(
              currentExtent: MediaQuery.of(context).size.height,
              minExtent: 250.0,
              maxExtent: MediaQuery.of(context).size.height,
              toolbarOpacity: 1.0,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: FlickVideoPlayer(
                        flickVideoWithControlsFullscreen: FlickFullScreenToggle().enterFullScreenChild,
                        flickManager: flickManager,
                    ),
                  ),
                  Stepper(

                      steps: [
                        for (var item in widget.videourl)
                          Step(title: Text(''), content: Text(''))
                      ],
                    currentStep: _currentIndex,
                    onStepContinue: () {

                    },
                    controlsBuilder: (BuildContext context, {
                      VoidCallback onStepContinue, VoidCallback onStepCancel
                    }) => Container(),
                  ),
              ]


              ),
            ),
          )
        ],
      ),
    );

      /*
      RotatedBox(
      quarterTurns: 1,
      child: FlickVideoPlayer(
          flickVideoWithControlsFullscreen: FlickFullScreenToggle().enterFullScreenChild,
          flickManager: flickManager
      ),
    );

       */
  }
}