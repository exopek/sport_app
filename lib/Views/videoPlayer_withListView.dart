import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_app/Notifyers/timerEnd_notifyer.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerList extends StatefulWidget {

  final List urlList;

  const VideoPlayerList({Key key,@required this.urlList}) : super(key: key);

  @override
  _VideoPlayerListState createState() => _VideoPlayerListState();
}

class _VideoPlayerListState extends State<VideoPlayerList> {

  PageController controller = PageController();

  TargetPlatform platform;
  VideoPlayerController _videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;
  //ChewieController chewieController;
  int selectedIndex;
  List<Color> listItemColor = new List<Color>();
  bool kill_playVideo;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    kill_playVideo = false;
    _videoPlayerController = VideoPlayerController.network(widget.urlList[0]);
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
    _videoPlayerController.setLooping(true);
    _videoPlayerController.play();
    timer();
    //selectedIndex = 0;

    //videoPlayerController.addListener(_videoListener);
    //chewieController = ChewieController(
      //videoPlayerController: videoPlayerController,
      //aspectRatio: 3 / 2,
      //autoPlay: true,
      //looping: true,
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
   // );
  }


  @override
  void dispose() {
    //chewieController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }


  void timer() async {
    final TimerNotifyer timerNotifyer = Provider.of<TimerNotifyer>(context);
    const oneSec = const Duration(seconds: 10);
    //selectedIndex = timerNotifyer.index;

      //imerNotifyer.update(i);
    Future.delayed(oneSec, () {
      final new_selectedIndex = 2;
      debugPrint('$new_selectedIndex');
      final new_videoPlayerController = VideoPlayerController.network(widget.urlList[new_selectedIndex]);
      final old_videoPlayerController = _videoPlayerController;
      if (old_videoPlayerController != null) {
        old_videoPlayerController.pause();
      }
      _videoPlayerController = new_videoPlayerController;
      //controller.jumpToPage(new_selectedIndex);
      setState(() {
        debugPrint('----- controller changed');
      });

      new_videoPlayerController
        ..initialize().then((_) {
          debugPrint("---- controller initialized");
          old_videoPlayerController?.dispose();
          new_videoPlayerController.setLooping(true);
          new_videoPlayerController.play();
          setState(() {});
        });

    });


  }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return PageView.builder(
                    itemBuilder: (context, position) {
                      return VideoPlayer(_videoPlayerController);
                    },
                    itemCount: widget.urlList.length,
                    controller: controller,
                  );
                } else {
                  return Container();
                }

              }
            )
        ),
      );
    }

    /*
    Widget _player() {
    timer().whenComplete(() {
      chewieController.play();
      return Container(
          color: Colors.red,
          child: Chewie(controller: chewieController));
    });


    }

     */

  }

