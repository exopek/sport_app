import 'dart:async';
import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Videos extends StatefulWidget {

  final List videourl;


  const Videos({Key key, this.videourl}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VideosState();
  }
}

class _VideosState extends State<Videos> {
  List playList = [
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    "https://www.sample-videos.com/video123/mp4/240/big_buck_bunny_240p_1mb.mp4",
    "https://file-examples.com/wp-content/uploads/2017/04/file_example_MP4_480_1_5MG.mp4",
    "http://techslides.com/demos/sample-videos/small.mp4"
  ];

  StepperType stepperType = StepperType.horizontal;

  TargetPlatform platform;
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;
  int selectedIndex;
  bool isPlaying = false, isEndPlaying = false;
  List<Color> listItemColor = new List<Color>();

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videourl[0]);
    selectedIndex = 0;
    //videoPlayerController.addListener(_videoListener);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: false,
      // Try playing around with some of these other options:
      // showControls: true,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  void timer() {
    Timer(Duration(seconds: 8) , () {
      setState(() {
        selectedIndex = selectedIndex + 1;

      });
      initVideoPlayer(selectedIndex);

    });
  }

  @override
  Widget build(BuildContext context) {
    if (selectedIndex < widget.videourl.length) {
      timer();
    }

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
                      //type: stepperType,
                      steps: [
                        for (var item in widget.videourl)
                          Step(title: Text(''), content: Text(''))
                      ],

                      currentStep: selectedIndex,
                      onStepTapped: (step) {
                        print('STEP: $step');
                        initVideoPlayer(step);
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


  // play view area
  Widget _playView() {
    chewieController.play();
    return Chewie(controller: chewieController);
  }

  Future initVideoPlayer(int _index) async {

    isPlaying = true;
    isEndPlaying = false;
    log("Video playing from " + widget.videourl[_index]);


    setState(() {
      //videoPlayerController.dispose();
      videoPlayerController = VideoPlayerController.network(widget.videourl[_index]);
      //chewieController.dispose();
      videoPlayerController.pause();
      videoPlayerController.seekTo(Duration(seconds: 0));
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 3 / 2,
        autoPlay: true,
        looping: false,
      );
    });
  }

  void _videoListener() {
    if (videoPlayerController.value.position ==
        videoPlayerController.value.duration) {
      print('video ended');
      isEndPlaying = true;
      isPlaying = false;
      setState(() {
        listItemColor[selectedIndex] = Colors.grey;
      });
    }
  }
}