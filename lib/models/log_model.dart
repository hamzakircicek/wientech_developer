import 'package:wien_tech_admin/models/user_model.dart';

class LogModel {
  final bool status;
  final List<Log> loglist;
  final Cursor cursor;
  final bool hasMore;
  LogModel({
    required this.status,
    required this.loglist,
    required this.cursor,
    required this.hasMore,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) => LogModel(
    status: json['status'] ?? false,
    loglist: json['logs'] == null ? [] : getLogList(json['logs']),
    cursor: Cursor.fromJson(json['nextCursor']),
    hasMore: json['hasMore'] ?? false,
  );

  static List<Log> getLogList(List json) =>
      json.map((e) => Log.fromJson(e)).toList();
}

class Log {
  final String logId;
  final String event;
  final String userId;
  final String? targetUserId;
  final String? provider;
  final String ipAdress;
  final String userAgent;
  final String reason;
  final String cratedAt;
  Log({
    required this.logId,
    required this.event,
    required this.userId,
    this.targetUserId,
    this.provider,
    required this.ipAdress,
    required this.userAgent,
    required this.reason,
    required this.cratedAt,
  });

  factory Log.fromJson(Map<String, dynamic> json) => Log(
    logId: json['_id'] ?? '',
    event: json['event'] ?? '',
    userId: json['user_id'] ?? '',
    provider: json['provider'] ?? '',
    targetUserId: json['target_user_id'] ?? '',
    ipAdress: json['ip_address'] ?? '',
    userAgent: json['user_agent'] ?? '',
    reason: json['reason'] ?? '',
    cratedAt: json['createdAt'] ?? '',
  );
}
