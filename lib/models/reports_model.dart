import 'package:wien_tech_admin/models/media_model.dart';
import 'package:wien_tech_admin/models/post_model.dart';
import 'package:wien_tech_admin/models/user_model.dart';

class ReportModel {
  final bool status;
  final List<Report> reportList;
  final Cursor? cursor;
  ReportModel({required this.status, required this.reportList, this.cursor});

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      status: json['status'],
      reportList: getReportList(json['reports']),
      cursor: json['cursor'] != null ? Cursor.fromJson(json['cursor']) : null,
    );
  }

  static List<Report> getReportList(List json) =>
      json.map((e) => Report.fromJson(e)).toList();
}

class Report {
  final String id;
  final String reportType;
  final String message;
  final User reporterUser;
  final User reportedUser;
  final String reportTargetType;
  final Post? post;
  final String? conversationId;
  final List<EvidenceMediaModel>? mediaList;
  final String reportStatus;
  final String adminNote;
  final String updatedAt;

  Report({
    required this.id,
    required this.reportType,
    required this.message,
    required this.reporterUser,
    required this.reportTargetType,
    required this.reportedUser,
    this.post,
    this.conversationId,
    required this.mediaList,
    required this.adminNote,
    required this.reportStatus,
    required this.updatedAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['_id'],
      reportType: json['report_type'],
      message: json['message'],
      reporterUser: User.fromJson(json['reporter_user']),
      reportedUser: User.fromJson(json['reported_user']),
      reportTargetType: json['report_target_type'],
      post: json['post'] != null ? Post.fromJson(json['post']) : null,
      mediaList: getMediaList(json['evidence_photos']),
      adminNote: json['admin_note'],
      reportStatus: json['status'],
      updatedAt: json['updatedAt'],
    );
  }

  static List<EvidenceMediaModel> getMediaList(List json) =>
      json.map((e) => EvidenceMediaModel.fromJson(e)).toList();
}
