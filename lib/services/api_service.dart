import 'package:dio/dio.dart';
import 'package:kiddopia/classes/models/video_model.dart';

const _kBaseURL = 'https://storage.googleapis.com/stream_thumbnails/ktv.json';

class ApiService {
  final _dio = Dio();
  Future<VideoModel> getVideos() async {
    final response = await _dio.get(_kBaseURL);
    final model = VideoModel.fromJson(response.data);
    return model;
  }
}
