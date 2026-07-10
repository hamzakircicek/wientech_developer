abstract class LogsEvent {}

class GetLogsEvent extends LogsEvent {
  String userId;
  GetLogsEvent({required this.userId});
}
