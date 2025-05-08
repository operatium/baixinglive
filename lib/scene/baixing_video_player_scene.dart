import 'dart:async';
import 'package:baixinglive/entity/baixing_video_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

/// 视频播放界面
/// 支持显示视频名称、返回按钮、基础播放控制和横竖屏切换
class Baixing_VideoPlayerScene extends StatefulWidget {
  final Baixing_VideoEntity mBaixing_videoEntity;

  const Baixing_VideoPlayerScene({
    Key? key,
    required this.mBaixing_videoEntity,
  }) : super(key: key);

  @override
  State<Baixing_VideoPlayerScene> createState() => _Baixing_VideoPlayerSceneState();
}

class _Baixing_VideoPlayerSceneState extends State<Baixing_VideoPlayerScene> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isFullScreen = false;
  bool _showControls = true;
  double _currentPosition = 0;
  double _totalDuration = 0;
  Timer? _hideControlsTimer;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  /// 初始化视频播放器
  void _initializeVideoPlayer() async {
    _controller = await VideoPlayerController.networkUrl(Uri.parse(widget.mBaixing_videoEntity.mBaixing_VideoUrl))
      ..initialize().then((_) {
        setState(() {
          _totalDuration = _controller.value.duration.inMilliseconds.toDouble();
        });
        _isInitialized = true;
        _startPlayback();
      });

    _controller.addListener(() {
      if (mounted) {
        setState(() {
          _currentPosition = _controller.value.position.inMilliseconds.toDouble();
          _isPlaying = _controller.value.isPlaying;
        });
      }
    });
  }

  /// 开始播放视频
  void _startPlayback() {
    _controller.play();
    setState(() {
      _isPlaying = true;
    });
    _startHideControlsTimer();
  }

  /// 启动隐藏控制层的定时器
  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && _isPlaying) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  /// 切换播放/暂停状态
  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      setState(() {
        _isPlaying = false;
        _showControls = true;
      });
      _hideControlsTimer?.cancel();
    } else {
      _controller.play();
      setState(() {
        _isPlaying = true;
        _showControls = true;
      });
      _startHideControlsTimer();
    }
  }

  /// 切换全屏/非全屏状态
  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });

    if (_isFullScreen) {
      _setOrientationLandscape();
    } else {
      _setOrientationPortrait();
    }
  }

  /// 设置横屏模式
  void _setOrientationLandscape() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  /// 设置竖屏模式
  void _setOrientationPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  /// 显示控制层
  void _showControlsOverlay() {
    setState(() {
      _showControls = true;
    });
    _startHideControlsTimer();
  }

  /// 格式化时间显示
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    _hideControlsTimer?.cancel();
    _controller.dispose();
    _setOrientationPortrait();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      _initializeVideoPlayer();
      _setOrientationPortrait();
      return Container(
        color: Colors.white,
        child: Center(
          child: CupertinoActivityIndicator(
            color: Colors.black,
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.black,
        body: OrientationBuilder(
          builder: (context, orientation) {
            final isLandscape = orientation == Orientation.landscape;
            return GestureDetector(
              onTap: _showControlsOverlay,
              child: Stack(
                children: [
                  // 视频播放器
                  Center(
                    child: _controller.value.isInitialized
                        ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                        : const CircularProgressIndicator(),
                  ),

                  // 控制层
                  if (_showControls)
                    Container(
                      color: Colors.black.withOpacity(0.4),
                      child: Column(
                        children: [
                          // 顶部栏
                          Container(
                            padding: EdgeInsets.only(
                              top: isLandscape ? 8 : MediaQuery
                                  .of(context)
                                  .padding
                                  .top + 8,
                              left: 16,
                              right: 16,
                              bottom: 8,
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                      Icons.arrow_back, color: Colors.white),
                                  onPressed: () {
                                    if (_isFullScreen) {
                                      _toggleFullScreen();
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                                Expanded(
                                  child: Text(
                                    widget.mBaixing_videoEntity
                                        .mBaixing_VideoName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),

                          // 底部控制栏
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // 进度条
                                SliderTheme(
                                  data: SliderThemeData(
                                    trackHeight: 2,
                                    thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 6),
                                    overlayShape: const RoundSliderOverlayShape(
                                        overlayRadius: 12),
                                    activeTrackColor: Colors.purple,
                                    inactiveTrackColor: Colors.grey[300],
                                    thumbColor: Colors.purple,
                                    overlayColor: Colors.purple.withOpacity(
                                        0.3),
                                  ),
                                  child: Slider(
                                    value: _currentPosition,
                                    min: 0,
                                    max: _totalDuration,
                                    onChanged: (value) {
                                      setState(() {
                                        _currentPosition = value;
                                      });
                                    },
                                    onChangeEnd: (value) {
                                      _controller.seekTo(Duration(
                                          milliseconds: value.toInt()));
                                    },
                                  ),
                                ),

                                // 时间和控制按钮
                                Row(
                                  children: [
                                    // 当前时间/总时间
                                    Text(
                                      "${_formatDuration(Duration(
                                          milliseconds: _currentPosition
                                              .toInt()))} / ${_formatDuration(
                                          Duration(milliseconds: _totalDuration
                                              .toInt()))}",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),

                                    const Spacer(),

                                    // 播放/暂停按钮
                                    IconButton(
                                      icon: Icon(
                                        _isPlaying ? Icons.pause : Icons
                                            .play_arrow,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                      onPressed: _togglePlayPause,
                                    ),

                                    // 全屏按钮
                                    IconButton(
                                      icon: Icon(
                                        _isFullScreen
                                            ? Icons.fullscreen_exit
                                            : Icons.fullscreen,
                                        color: Colors.white,
                                      ),
                                      onPressed: _toggleFullScreen,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      );
    }
  }
}