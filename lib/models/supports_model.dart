import 'package:wien_tech_admin/models/user_model.dart';

class SupportModel {
  final bool status;
  final List<Support> supportlist;
  final Cursor? cursor;
  SupportModel({required this.status, required this.supportlist, this.cursor});

  factory SupportModel.fromJson(Map<String, dynamic> json) {
    return SupportModel(
      status: json['status'],
      supportlist: json['supportlist'],
      cursor: json['nextCursor'],
    );
  }

  static List<Support> getReportList(List json) =>
      json.map((e) => Support.fromJson(e)).toList();
}

class Support {
  final String id;
  final String supportType;
  final String message;
  final User suporterUser;

  final String supportStatus;
  final String adminNote;
  final String updatedAt;

  Support({
    required this.id,
    required this.supportType,
    required this.message,
    required this.suporterUser,
    required this.adminNote,
    required this.supportStatus,
    required this.updatedAt,
  });

  factory Support.fromJson(Map<String, dynamic> json) {
    return Support(
      id: json['id'],
      supportType: json['support_type'],
      message: json['message'],
      suporterUser: User.fromJson(json['support_user']),
      adminNote: json['admin_note'],
      supportStatus: json['status'],
      updatedAt: json['updatedAt'],
    );
  }
}
