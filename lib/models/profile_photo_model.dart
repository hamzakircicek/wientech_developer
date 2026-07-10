import 'package:wien_tech_admin/models/user_model.dart';

class ProfilePhotoModel {
  final bool status;
  final List<ProfilePhoto> profilePhotoList;
  final Cursor? cursor;
  final bool hasMore;

  ProfilePhotoModel({
    required this.status,
    required this.profilePhotoList,
    required this.hasMore,
    this.cursor,
  });

  factory ProfilePhotoModel.fromJson(Map<String, dynamic> json) {
    return ProfilePhotoModel(
      status: json['status'],
      profilePhotoList: getProfilePhotoList(json['profilePhotoList']),
      hasMore: json['hasMore'],
    );
  }

  static List<ProfilePhoto> getProfilePhotoList(List json) {
    return json.map((e) => ProfilePhoto.fromJson(e)).toList();
  }
}

class ProfilePhoto {
  final String id;
  final User user;
  final String cdnKey;
  final String updatedAt;
  ProfilePhoto({
    required this.id,
    required this.user,
    required this.cdnKey,
    required this.updatedAt,
  });

  factory ProfilePhoto.fromJson(Map<String, dynamic> json) {
    return ProfilePhoto(
      id: json['_id'],
      user: User.fromJson(json['user_id']),
      cdnKey: json['cdn_key'],
      updatedAt: json['updatedAt'],
    );
  }
}
