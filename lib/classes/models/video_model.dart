class VideoModel {
  List<Video>? videos;

  VideoModel({this.videos});

  VideoModel.fromJson(Map<String, dynamic> json) {
    if (json['ktvJsonVideosList'] != null) {
      videos = <Video>[];
      json['ktvJsonVideosList'].forEach((v) {
        videos!.add(Video.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (videos != null) {
      data['ktvJsonVideosList'] = videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Video {
  int? index;
  String? title;
  String? ktvThumbnailUrl;
  String? ktvVideoUrl;

  Video({this.index, this.title, this.ktvThumbnailUrl, this.ktvVideoUrl});

  Video.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    title = json['title'];
    ktvThumbnailUrl = json['ktvThumbnailUrl'];
    ktvVideoUrl = json['ktvVideoUrl'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['index'] = index;
    data['title'] = title;
    data['ktvThumbnailUrl'] = ktvThumbnailUrl;
    data['ktvVideoUrl'] = ktvVideoUrl;
    return data;
  }
}
