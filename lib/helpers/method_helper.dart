import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:kiddopia/classes/models/video_model.dart';

Future<VideoModel> loadVideos() async {
  final jsonString = await rootBundle.loadString('assets/json_data/data.json');
  final Map<String, dynamic> jsonMap = json.decode(jsonString) as Map<String, dynamic>;
  final model = VideoModel.fromJson(jsonMap);
  model.videos!.add(Video(index: -111));
  return model;
}

Future zeroDelay() async => const Duration();
