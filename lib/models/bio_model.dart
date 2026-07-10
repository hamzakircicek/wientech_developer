import 'package:wien_tech_admin/models/user_model.dart';

class BioModel {
  final bool status;
  final List<Bio> bioList;
  final Cursor? cursor;
  final bool hasMore;

  BioModel({
    required this.status,
    required this.bioList,
    required this.hasMore,
    this.cursor,
  });

  factory BioModel.fromJson(Map<String, dynamic> json) {
    return BioModel(
      status: json['status'],
      bioList: getBioList(json['bioList']),
      hasMore: json['hasMore'],
    );
  }

  static List<Bio> getBioList(List json) {
    return json.map((e) => Bio.fromJson(e)).toList();
  }
}

class Bio {
  final String id;
  final User user;
  final String bio;
  final String updatedAt;
  Bio({
    required this.id,
    required this.user,
    required this.bio,
    required this.updatedAt,
  });

  factory Bio.fromJson(Map<String, dynamic> json) {
    return Bio(
      id: json['_id'] ?? '',
      user: User.fromJson(json['user_id']),
      bio: json['bio'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
