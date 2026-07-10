class MediaModel {
  String cdnKey;
  String cdnUrl;
  MediaModel({required this.cdnKey, required this.cdnUrl});

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(cdnKey: json['key'], cdnUrl: json['url']);
  }
}
