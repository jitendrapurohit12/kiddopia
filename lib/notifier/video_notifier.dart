import 'package:flutter/material.dart';
import 'package:kiddopia/classes/enums/enums.dart';
import 'package:kiddopia/classes/models/video_model.dart';
import 'package:kiddopia/helpers/method_helper.dart';
import 'package:kiddopia/main.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoNotifier extends ChangeNotifier {
  Video? _model;
  List<Video> _playlist = [];
  VideoPlayerController? _controller;
  bool _isPlaying = true, _playedNext = false;
  NotifierState _state = NotifierState.initial;

  Future reset() async {
    _model = null;
    _playlist = [];
    _isPlaying = true;
    _controller?.dispose();
    _controller = null;
    _state = NotifierState.initial;
    notifyListeners();
  }

  Video? get modele => _model;
  bool get isPlaying => _isPlaying;
  NotifierState get state => _state;
  List<Video> get playlist => _playlist;
  VideoPlayerController? get controller => _controller;

  set model(Video model) => _model = model;

  Future initController(BuildContext context) async {
    _state = NotifierState.initial;
    await zeroDelay();
    notifyListeners();

    _createPlaylist(context);

    _controller?.dispose();
    _controller = null;
    _controller = VideoPlayerController.network(_model!.ktvVideoUrl!);
    await _controller!.initialize().catchError((e) {
      print(e);
    });
    await _controller!.play();
    _isPlaying = true;
    _playedNext = false;
    _controller!.addListener(() {
      final isPlaying = _controller!.value.isPlaying;
      final isEnded = _controller!.value.duration == _controller!.value.position;
      if (!isPlaying && isEnded && !_playedNext) playNext(context);
    });

    _state = NotifierState.done;
    await zeroDelay();
    notifyListeners();
  }

  Future togglePause() async {
    _isPlaying ? await _controller!.pause() : await _controller!.play();
    _isPlaying = !_isPlaying;
    await zeroDelay();
    notifyListeners();
  }

  Future playNext(BuildContext context) async {
    _playedNext = true;
    final list = context.read(dashboardPod).model!.videos!;
    final index = list.indexOf(_model!);
    final newIndex = index < list.length - 1 ? index + 1 : 0;
    _model = list[newIndex];
    _createPlaylist(context);
    initController(context);
  }

  void _createPlaylist(BuildContext context) {
    _playlist.clear();
    final list = context.read(dashboardPod).model!.videos!;
    _playlist.addAll(
        list.where((element) => element.index! != _model!.index! && element.index! != -111));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
