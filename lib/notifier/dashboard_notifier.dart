import 'package:flutter/material.dart';
import 'package:kiddopia/classes/enums/enums.dart';
import 'package:kiddopia/classes/models/video_model.dart';
import 'package:kiddopia/constants/constant.dart';
import 'package:kiddopia/helpers/method_helper.dart';
import 'package:velocity_x/velocity_x.dart';

class DashboardNotifier extends ChangeNotifier {
  VideoModel? _model;
  NotifierState _state = NotifierState.initial;
  int _page = 0, _totalPages = 0, _totalVideos = 0;

  int get page => _page;
  VideoModel? get model => _model;
  int get totalPage => _totalPages;
  NotifierState get state => _state;
  int get totalVideos => _totalVideos;

  Future init() async {
    await Future.delayed(5.seconds);
    final model = await loadVideos();

    _model = model;
    _totalVideos = model.videos!.length;
    _totalPages = (model.videos!.length / videosPerPage).ceil();

    _state = NotifierState.done;
    notifyListeners();
  }

  void changePage(int newPage) {
    _page = newPage;
    notifyListeners();
  }
}
