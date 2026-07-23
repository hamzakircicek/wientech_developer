enum SupportType {
  initial,
  suggestion,
  technic,
  premium,
  account,
  post,
  security,
  message,
  profile,
}

enum SupportStatus { pending, solved, rejected }

class AllSupportsModel {
  final bool status;
  final List<SupportModel> supports;
  final SupportCursor? cursor;
  final bool hasMore;

  AllSupportsModel({
    required this.status,
    required this.supports,
    this.cursor,
    required this.hasMore,
  });

  factory AllSupportsModel.fromJson(Map<String, dynamic> j) => AllSupportsModel(
    status: j["status"],
    supports: SupportModel.getSupportsModelList(j["supports"]),
    cursor: j["cursor"] != null ? SupportCursor.fromJson(j["cursor"]) : null,
    hasMore: j["hasMore"],
  );
}

class SupportModel {
  final String id;
  final SupportType type;
  final String message;
  final SupportUserModel user;
  final SupportStatus supportStatus;
  SupportModel({
    required this.id,
    required this.type,
    required this.supportStatus,
    required this.user,
    required this.message,
  });

  factory SupportModel.fromJson(Map<String, dynamic> json) => SupportModel(
    id: json['_id'],
    type: parseSupportType(json['support_type']),
    message: json['message'],
    user: SupportUserModel.fromJson(json['supported_user']),
    supportStatus: parseSupportStatus(json['support_status']),
  );

  static List<SupportModel> getSupportsModelList(List json) {
    return json
        .map((e) => SupportModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  static SupportType parseSupportType(String type) {
    switch (type) {
      case 'premium':
        return SupportType.premium;
      case 'account':
        return SupportType.account;
      case 'post':
        return SupportType.post;
      case 'security':
        return SupportType.security;
      case 'message':
        return SupportType.message;
      case 'profile':
        return SupportType.profile;
      case 'technic':
        return SupportType.technic;
      case 'suggestion':
        return SupportType.suggestion;
      default:
        return SupportType.initial;
    }
  }

  static SupportStatus parseSupportStatus(String type) {
    switch (type) {
      case 'pending':
        return SupportStatus.pending;
      case 'solved':
        return SupportStatus.solved;
      case 'rejected':
        return SupportStatus.rejected;
      default:
        return SupportStatus.pending;
    }
  }
}

class SupportUserModel {
  String id;
  String userName;
  String userProfilePhotoUrl;
  SupportUserModel({
    required this.id,
    required this.userName,
    required this.userProfilePhotoUrl,
  });

  factory SupportUserModel.fromJson(Map<String, dynamic> json) =>
      SupportUserModel(
        id: json['_id'],
        userName: json['user_name'],
        userProfilePhotoUrl: json['profile_photo_url'],
      );
}

class SendedSupportModel {
  final bool status;
  final String? supportId;
  final String supportMessage;

  SendedSupportModel({
    required this.status,
    this.supportId,
    required this.supportMessage,
  });

  factory SendedSupportModel.fromJson(Map<String, dynamic> json) =>
      SendedSupportModel(
        status: json['status'],
        supportId: json['support_id'],
        supportMessage: json['message'],
      );
}

class SupportCursor {
  final String? createdAt;
  final String? id;
  SupportCursor({this.createdAt, this.id});

  factory SupportCursor.fromJson(Map<String, dynamic> json) =>
      SupportCursor(createdAt: json['createdAt'] ?? '', id: json['_id'] ?? '');
  static Map<String, dynamic> toMap(SupportCursor? cursor) {
    if (cursor == null) {
      return {};
    } else {
      return {'createdAt': cursor.createdAt, '_id': cursor.id};
    }
  }
}
