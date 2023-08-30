import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/common/style/app_colors.dart';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../controllers/video_controller.dart';

class VideoView extends GetView<VideoController> {
  const VideoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(children: [
        VideoPageBuilder(
          asset: controller.asset!,
          hasOnlyOneVideoAndMoment: true,
        ),
        Positioned(
            left: 15,
            top: 50,
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                ))),
      ]),
    );
  }
}

class VideoPageBuilder extends StatefulWidget {
  const VideoPageBuilder({
    super.key,
    required this.asset,
    this.hasOnlyOneVideoAndMoment = false,
  });

  /// Asset currently displayed.
  /// 展示的资源
  final AssetEntity asset;

  /// Only previewing one video and with the [SpecialPickerType.wechatMoment].
  /// 是否处于 [SpecialPickerType.wechatMoment] 且只有一个视频
  final bool hasOnlyOneVideoAndMoment;

  @override
  State<VideoPageBuilder> createState() => _VideoPageBuilderState();
}

class _VideoPageBuilderState extends State<VideoPageBuilder> {
  /// Controller for the video player.
  /// 视频播放的控制器
  VideoPlayerController get controller => _controller!;
  VideoPlayerController? _controller;

  /// Whether the controller has initialized.
  /// 控制器是否已初始化
  bool hasLoaded = false;

  /// Whether there's any error when initialize the video controller.
  /// 初始化视频控制器时是否发生错误
  bool hasErrorWhenInitializing = false;

  /// Whether the player is playing.
  /// 播放器是否在播放
  final ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);

  /// Whether the controller is playing.
  /// 播放控制器是否在播放
  bool get isControllerPlaying => _controller?.value.isPlaying ?? false;

  bool _isInitializing = false;
  bool _isLocallyAvailable = false;

  @override
  void didUpdateWidget(VideoPageBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.asset != oldWidget.asset) {
      _controller
        ?..removeListener(videoPlayerListener)
        ..pause()
        ..dispose();
      _controller = null;
      hasLoaded = false;
      hasErrorWhenInitializing = false;
      isPlaying.value = false;
      _isInitializing = false;
      _isLocallyAvailable = false;
    }
  }

  @override
  void dispose() {
    /// Remove listener from the controller and dispose it when widget dispose.
    /// 部件销毁时移除控制器的监听并销毁控制器。
    _controller
      ?..removeListener(videoPlayerListener)
      ..pause()
      ..dispose();
    super.dispose();
  }

  /// Get media url from the asset, then initialize the controller and add with a listener.
  /// 从资源获取媒体url后初始化，并添加监听。
  Future<void> initializeVideoPlayerController() async {
    _isInitializing = true;
    _isLocallyAvailable = true;
    final String? url = await widget.asset.getMediaUrl();
    if (url == null) {
      hasErrorWhenInitializing = true;
      if (mounted) {
        setState(() {});
      }
      return;
    }
    final Uri uri = Uri.parse(url);
    if (Platform.isAndroid) {
      _controller = VideoPlayerController.contentUri(uri);
    } else {
      _controller = VideoPlayerController.networkUrl(uri);
    }
    try {
      await controller.initialize();
      hasLoaded = true;
      controller
        ..addListener(videoPlayerListener)
        ..setLooping(widget.hasOnlyOneVideoAndMoment);
      if (widget.hasOnlyOneVideoAndMoment) {
        controller.play();
      }
    } catch (e, s) {
      FlutterError.presentError(
        FlutterErrorDetails(
          exception: e,
          stack: s,
          library: "packageName",
          silent: true,
        ),
      );
      hasErrorWhenInitializing = true;
    } finally {
      if (mounted) {
        setState(() {});
      }
    }
  }

  /// Listener for the video player.
  /// 播放器的监听方法
  void videoPlayerListener() {
    if (isControllerPlaying != isPlaying.value) {
      isPlaying.value = isControllerPlaying;
    }
  }

  /// Callback for the play button.
  /// 播放按钮的回调
  ///
  /// Normally it only switches play state for the player. If the video reaches the end,
  /// then click the button will make the video replay.
  /// 一般来说按钮只切换播放暂停。当视频播放结束时，点击按钮将从头开始播放。
  Future<void> playButtonCallback(BuildContext context) async {
    if (isPlaying.value) {
      controller.pause();
      return;
    }
    if (controller.value.duration == controller.value.position) {
      controller
        ..seekTo(Duration.zero)
        ..play();
      return;
    }
    controller.play();
  }

  Widget _contentBuilder(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned.fill(
          child: Center(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),
        ),
        if (!widget.hasOnlyOneVideoAndMoment)
          ValueListenableBuilder<bool>(
            valueListenable: isPlaying,
            builder: (_, bool value, __) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => playButtonCallback(context),
              child: Center(
                child: AnimatedOpacity(
                  duration: kThemeAnimationDuration,
                  opacity: value ? 0.0 : 1.0,
                  child: GestureDetector(
                    onTap: () => playButtonCallback(context),
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: Colors.black12)
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        value
                            ? Icons.pause_circle_outline
                            : Icons.play_circle_filled,
                        size: 70.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LocallyAvailableBuilder(
      key: ValueKey<String>(widget.asset.id),
      asset: widget.asset,
      builder: (BuildContext context, AssetEntity asset) {
        if (hasErrorWhenInitializing) {
          return Center(
              // child: ScaleText(
              //   Singleton.textDelegate.loadFailed,
              //   semanticsLabel:
              //       Singleton.textDelegate.semanticsTextDelegate.loadFailed,
              // ),
              );
        }
        if (!_isLocallyAvailable && !_isInitializing) {
          initializeVideoPlayerController();
        }
        if (!hasLoaded) {
          return const SizedBox.shrink();
        }
        return Semantics(
          onLongPress: () => playButtonCallback(context),
          // onLongPressHint:
          //     Singleton.textDelegate.semanticsTextDelegate.sActionPlayHint,
          child: _contentBuilder(context),
        );
      },
    );
  }
}

class LocallyAvailableBuilder extends StatefulWidget {
  const LocallyAvailableBuilder({
    super.key,
    required this.asset,
    required this.builder,
    this.isOriginal = true,
  });

  final AssetEntity asset;
  final Widget Function(BuildContext context, AssetEntity asset) builder;
  final bool isOriginal;

  @override
  State<LocallyAvailableBuilder> createState() =>
      _LocallyAvailableBuilderState();
}

class _LocallyAvailableBuilderState extends State<LocallyAvailableBuilder> {
  bool _isLocallyAvailable = false;
  PMProgressHandler? _progressHandler;

  @override
  void initState() {
    super.initState();
    _checkLocallyAvailable();
  }

  @override
  void didUpdateWidget(LocallyAvailableBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.asset != oldWidget.asset ||
        widget.isOriginal != oldWidget.isOriginal) {
      _isLocallyAvailable = false;
      _progressHandler = null;
      _checkLocallyAvailable();
    }
  }

  Future<void> _checkLocallyAvailable() async {
    _isLocallyAvailable = await widget.asset.isLocallyAvailable(
      isOrigin: widget.isOriginal,
    );
    if (!mounted) {
      return;
    }
    setState(() {});
    if (!_isLocallyAvailable) {
      _progressHandler = PMProgressHandler();
      Future<void>(() async {
        final File? file = await widget.asset.loadFile(
          isOrigin: widget.isOriginal,
          withSubtype: true,
          progressHandler: _progressHandler,
        );
        if (file != null) {
          _isLocallyAvailable = true;
          if (mounted) {
            setState(() {});
          }
        }
      });
    }
    _progressHandler?.stream.listen((PMProgressState s) {
      assert(() {
        return true;
      }());
      if (s.state == PMRequestState.success) {
        _isLocallyAvailable = true;
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  Widget _indicator(BuildContext context) {
    return StreamBuilder<PMProgressState>(
      stream: _progressHandler!.stream,
      initialData: const PMProgressState(0, PMRequestState.prepare),
      builder: (BuildContext c, AsyncSnapshot<PMProgressState> s) {
        if (s.hasData) {
          final double progress = s.data!.progress;
          final PMRequestState state = s.data!.state;
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                state == PMRequestState.failed
                    ? Icons.cloud_off
                    : Icons.cloud_queue,
                // color: context.iconTheme.color?.withOpacity(.4),
                size: 28,
              ),
              // if (state != PMRequestState.success &&
              //     state != PMRequestState.failed)
              //   ScaleText(
              //     '  iCloud ${(progress * 100).toInt()}%',
              //     style: TextStyle(
              //       color: context.textTheme.bodyMedium?.color
              //           ?.withOpacity(.4),
              //     ),
              //   ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLocallyAvailable) {
      return widget.builder(context, widget.asset);
    }
    if (_progressHandler != null) {
      return Center(child: _indicator(context));
    }
    return const SizedBox.shrink();
  }
}
