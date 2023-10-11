import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wakelock/wakelock.dart';
import 'package:youtube/youtube.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../AppTheme/colorConstants.dart';
import '../../Models/MovieTrailersResponseModel/movieTrailersResponseModel.dart';

class VideoPlayerPage extends StatefulWidget {
  final MovieTrailerData? movieTrailerData;
  const VideoPlayerPage({super.key, this.movieTrailerData});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  YoutubePlayerController? _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId: widget.movieTrailerData!.key!,
        flags: const YoutubePlayerFlags(autoPlay: true, controlsVisibleAtStart: true));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    Wakelock.enable();
    super.initState();
  }

  @override
  Future<void> dispose() async {
    // TODO: implement dispose
    super.dispose();
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          backToDetailPage();
          return Future.value(true);
        },
        child: videoPlayer(_controller!));
  }

  YoutubePlayerBuilder videoPlayer(YoutubePlayerController _controller, ) {

    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          onEnded: (meta){
            backToDetailPage();
          },
          topActions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w),
              child: InkWell(
                onTap: () {
                  backToDetailPage();
                },
                child: SizedBox(
                  height: 30.sp,
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        size: 8.sp,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        "Back",
                        style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500, color: ColorConstants.white),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        builder: (context, player) {
          return player;
        });
  }


  backToDetailPage() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    SystemChrome.restoreSystemUIOverlays();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    Wakelock.disable();
    Navigator.pop(context);
  }
}
