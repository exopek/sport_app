import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class SamplePlayer extends StatefulWidget {
  final videourl;
  SamplePlayer({Key key, @required this.videourl}) : super(key: key);

  @override
  _SamplePlayerState createState() => _SamplePlayerState();
}

class _SamplePlayerState extends State<SamplePlayer> {
  FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    print(widget.videourl);
    flickManager = FlickManager(
      autoPlay: true,
      videoPlayerController:
        VideoPlayerController.network(widget.videourl)

    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: FlickVideoPlayer(
          flickVideoWithControlsFullscreen: FlickFullScreenToggle().enterFullScreenChild,
          flickManager: flickManager
      ),
    );
  }
}