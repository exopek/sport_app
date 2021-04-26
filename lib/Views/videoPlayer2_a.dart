import 'dart:async';

import 'package:flutter/foundation.dart';
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
  FlickManager _flickManager;

  VideoPlayerController videoPlayerController;

  String _videoUrl;

  int _currentIndex;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videourl[0]);
    _currentIndex = 0;
    //videoPlayerController.addListener(());
    _videoUrl = widget.videourl[_currentIndex];
    print(_videoUrl);
    _flickManager = FlickManager(
        
        autoPlay: true,
        videoPlayerController: videoPlayerController


    );
    //_flickManager.flickVideoManager.videoPlayerController.setLooping(true);
  }

  void initVideoPlayer() async {

    if (_currentIndex <= widget.videourl.length) {
      _currentIndex += 1;
      _videoUrl = widget.videourl[_currentIndex];

      videoPlayerController = VideoPlayerController.network(widget.videourl[_currentIndex]);

      setState(() {
        _flickManager.dispose();
        videoPlayerController.pause();
        videoPlayerController.seekTo(Duration(seconds: 0));
        _flickManager = FlickManager(
            autoPlay: true,
            videoPlayerController: videoPlayerController



        );
        _flickManager.flickVideoManager.videoPlayerController.pause();
        _flickManager.flickVideoManager.videoPlayerController.seekTo(Duration(seconds: 0));

      });
      // ToDo: Timer Liste kommt hier noch hin
      print('currentIndex: $_currentIndex');
      print('videoUrl: $_videoUrl');
    } else {
      // ToDo: PageRoute,das Workout ist beendet
    }


    //_flickManager.flickVideoManager.videoPlayerController.setLooping(true);
  }


  @override
  void dispose() {
    //_flickManager.flickVideoManager.videoPlayerController.pause();
    videoPlayerController.dispose();
    _flickManager.dispose();
    super.dispose();
  }



  void timer() {
    Timer(Duration(seconds: 8) , () {
      initVideoPlayer();
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
                    child: _playView()
                  ),
                  Stepper(

                      steps: [
                        for (var item in widget.videourl)
                          Step(title: Text(''), content: Text(''))
                      ],

                    currentStep: _currentIndex,
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

  Widget _playView() {
    print('duration: ${_flickManager.flickVideoManager.videoPlayerController.value.duration}');
    _flickManager.flickVideoManager.videoPlayerController.play();
    return FlickVideoPlayer(
        flickVideoWithControlsFullscreen: FlickFullScreenToggle()
          ..enterFullScreenChild,
        flickManager: _flickManager


    );
  }
}