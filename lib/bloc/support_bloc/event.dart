import 'package:flutter/material.dart';
import 'package:wien_tech_admin/models/supports_model.dart';

abstract class SupportEvent {}

class SendSupportEvent extends SupportEvent {
  String supportType;
  String supportMessage;
  BuildContext context;
  SendSupportEvent({
    required this.supportType,
    required this.context,
    required this.supportMessage,
  });
}

class ResetSupportEvent extends SupportEvent {}

class GetSupportsEvent extends SupportEvent {
  String? userId;
  GetSupportsEvent({this.userId});
}

class LoadMoreEvent extends SupportEvent {
  SupportCursor? cursor;
  String? userId;
  LoadMoreEvent({this.cursor, this.userId});
}

class ChangeSupportTypeEvent extends SupportEvent {
  String type;
  ChangeSupportTypeEvent({required this.type});
}
