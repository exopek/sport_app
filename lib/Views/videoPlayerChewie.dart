import 'dart:async';
import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_app/Helpers/blank.dart';
import 'package:video_app/Notifyers/timerEnd_notifyer.dart';
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

  //Timer _timer;

  TargetPlatform platform;
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;
  int selectedIndex;
  bool isPlaying = false, isEndPlaying = false;
  List<Color> listItemColor = new List<Color>();
  bool kill_playVideo;


  void initialize() {
    videoPlayerController = VideoPlayerController.network(widget.videourl[0]);
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
  void initState() {
    super.initState();
    kill_playVideo = false;
    videoPlayerController = VideoPlayerController.network(widget.videourl[0]);
    //selectedIndex = 0;

    //videoPlayerController.addListener(_videoListener);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
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

    //videoPlayerController.pause();
    //chewieController.pause();
    //videoPlayerController = null;
    //chewieController = null;

    print('Hat der videoPlayer noch zuhörer: ${videoPlayerController.hasListeners}');
    //chewieController.videoPlayerController.removeListener(_videoListener);
    print('DISPOSE!!!!!');

    chewieController.dispose();
    videoPlayerController.dispose();

    super.dispose();
  }





  Future<void> timer() async {
    final TimerNotifyer timerNotifyer = Provider.of<TimerNotifyer>(context);
    const oneSec = const Duration(seconds: 10);
    selectedIndex = timerNotifyer.index;
    Future.delayed(oneSec, () {
      if (selectedIndex < widget.videourl.length - 1) {
        timerNotifyer.update(selectedIndex);
      }
      selectedIndex = timerNotifyer.index;
      print('selectedIndex: $selectedIndex');
      if (mounted && selectedIndex < widget.videourl.length - 1 && kill_playVideo == false) {
        initVideoPlayer(selectedIndex);
      } else if (mounted && selectedIndex == widget.videourl.length - 1 && kill_playVideo == false) {
        initVideoPlayer_with_kill_comment(selectedIndex);
      } else if (kill_playVideo == true) {
        shuttDownVideoPlayer();
      }

    });
    /*

    _timer = Timer.periodic(oneSec, (Timer timer) =>

        setState(() {

          if (selectedIndex == widget.videourl.length - 1) {
            print('Index where Timer should be deactivate: $selectedIndex');
            timer.cancel();
          } else {
            selectedIndex = selectedIndex + 1;
          }
        })
    );

     */





  }

  @override
  Widget build(BuildContext context) {
    final TimerNotifyer timerNotifyer = Provider.of<TimerNotifyer>(context);
    int selected = timerNotifyer.index;
    if (selected < widget.videourl.length) {
      print('timertimertimertimer');
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
                      Consumer<TimerNotifyer>(
                          builder: (context, data, child) {
                              return Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: _playView(data.index)
                              );
                          }
                      ),
                      Consumer<TimerNotifyer>(
                          builder: (context, data, child) {
                            print('currentStep: ${data.index}');
                            return Stepper(
                              //type: stepperType,
                              steps: [
                                for (int i = 0; i < widget.videourl.length; i++)
                                  Step(title: Text(''), content: Text(''))
                              ],

                              currentStep: data.index,
                              onStepTapped: (step) {
                                print('STEP: $step');
                                initVideoPlayer(step);
                              },
                              controlsBuilder: (BuildContext context, {
                                VoidCallback onStepContinue, VoidCallback onStepCancel
                              }) => Container(),
                            );
                          }
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
  Widget _playView(_index) {

    /*
    if (_index == widget.videourl.length - 1) {
      //_timer.cancel();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return BlankPage(); //Hier was machen
          },
        ),
      );
    } else if (_index < widget.videourl.length){
      timer();
    }

     */
    if (mounted && kill_playVideo == false) {
      chewieController.play();
      return Chewie(controller: chewieController);
    } else if (mounted) {
      return Builder(
          builder: (context) {
            return Container(
              color: Colors.white,
            );
          });
    }

  }

  void shuttDownVideoPlayer() async {
    setState(() {
      log('shuttDown');
      videoPlayerController =  VideoPlayerController.network(null);
      chewieController.dispose();
      //videoPlayerController.pause();
      //videoPlayerController.seekTo(Duration(seconds: 0));
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 3 / 2,
        autoPlay: false,
        looping: false,
      );
      chewieController.dispose();
      videoPlayerController.dispose();
    });
  }

  Future<void> initVideoPlayer_with_kill_comment(int _index) async {
    print('initVideoPlayer-Index: $_index');
    isPlaying = true;
    isEndPlaying = false;
    log("Video playing from " + widget.videourl[_index]);
    log('kill_comment');
    videoPlayerController.pause();


    if (mounted) {
      setState(() {
        //videoPlayerController = null;
        videoPlayerController = VideoPlayerController.network(widget.videourl[_index]);
        chewieController.dispose();
        videoPlayerController.pause();
        videoPlayerController.seekTo(Duration(seconds: 0));
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          aspectRatio: 3 / 2,
          autoPlay: true,
          looping: true,
        );
        kill_playVideo = true;
      });
    }
  }

  Future<void> initVideoPlayer(int _index) async {
    print('initVideoPlayer-Index: $_index');
    isPlaying = true;
    isEndPlaying = false;
    log("Video playing from " + widget.videourl[_index]);
    log('initVideo');
    videoPlayerController.pause();





        if (mounted) {
          setState(() {
            //videoPlayerController = null;


            videoPlayerController =  VideoPlayerController.network(widget.videourl[_index]);
            chewieController.dispose();
            videoPlayerController.pause();
            videoPlayerController.seekTo(Duration(seconds: 0));
            chewieController = ChewieController(
              videoPlayerController: videoPlayerController,
              aspectRatio: 3 / 2,
              autoPlay: true,
              looping: true,
            );
          });
        }




  }

  void _videoListener() {
    final TimerNotifyer timerNotifyer = Provider.of<TimerNotifyer>(context, listen: false);
    if (timerNotifyer.index == widget.videourl.length
        ) {
      print('video ended');
      isEndPlaying = true;
      isPlaying = false;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => TimerNotifyer()),
              ], child: BlankPage(),
            );

          },
        ),
      );


      dispose();
    }
  }
}