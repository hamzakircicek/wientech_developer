import 'package:wien_tech_admin/models/log_model.dart';

enum LogsPageState { loading, fail, success }

class LogsState {
  final bool? hasMore;
  final List<Log>? logs;
  final LogsPageState? logsPageStatus;
  const LogsState({
    this.hasMore,
    this.logs,
    this.logsPageStatus = LogsPageState.loading,
  });

  LogsState copyWith({
    bool? hasMore,
    List<Log>? logs,
    LogsPageState? logsPageStatus,
  }) {
    return LogsState(
      hasMore: hasMore ?? false,
      logs: logs ?? this.logs,
      logsPageStatus: logsPageStatus ?? this.logsPageStatus,
    );
  }
}

class Logs {}
