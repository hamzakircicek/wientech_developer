class MediaModel {
  String cdnKey;
  String cdnUrl;
  MediaModel({required this.cdnKey, required this.cdnUrl});

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(cdnKey: json['cdnKey'], cdnUrl: json['cdnUrl']);
  }
}

class EvidenceMediaModel {
  String cdnKey;
  String cdnUrl;
  EvidenceMediaModel({required this.cdnKey, required this.cdnUrl});

  factory EvidenceMediaModel.fromJson(Map<String, dynamic> json) {
    return EvidenceMediaModel(cdnKey: json['key'], cdnUrl: json['url']);
  }
}
