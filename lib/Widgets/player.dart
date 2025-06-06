import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../Constants/colors.dart';

class Player extends StatefulWidget {
  final String link;
  const Player({super.key, required this.link});

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late YoutubePlayerController _controller;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.link)!,
      flags: const YoutubePlayerFlags(autoPlay: true),
    );
    YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: false,
      progressIndicatorColor: Colors.amber,
      progressColors: const ProgressBarColors(
        playedColor: Colors.amber,
        handleColor: Colors.amberAccent,
      ),
    );
    _controller.addListener(_onControllerChange);
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void _onControllerChange() {
    if (_controller.value.isFullScreen && !_isFullScreen) {
      setState(() {
        _isFullScreen = true;
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      });
    } else if (!_controller.value.isFullScreen && _isFullScreen) {
      setState(() {
        _isFullScreen = false;
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      });
    }
  }

  Future<bool> _onWillPop() async {
    if (_isFullScreen) {
      _controller.toggleFullScreenMode();
      return false; // Prevents the app from closing
    }
    return true; // Allows the app to close
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: OrientationBuilder(
          builder: (context, orientation) {
            return buildPlayer(context);
          },
        ),
      ),
    );
  }

  Widget buildPlayer(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: YoutubePlayer(
          controller: _controller,
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: 40.h,
      left: 20.w,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: CircleAvatar(
          backgroundColor: shadowColor,
          radius: 20.sp,
          child: Icon(
            Icons.arrow_back,
            color: primaryTextColor,
            size: 24.sp,
          ),
        ),
      ),
    );
  }
}
