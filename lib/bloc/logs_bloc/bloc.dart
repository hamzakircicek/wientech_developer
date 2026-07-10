import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/api_services/api_service.dart';
import 'package:wien_tech_admin/bloc/logs_bloc/event.dart';
import 'package:wien_tech_admin/bloc/logs_bloc/state.dart';

class LogsBloc extends Bloc<LogsEvent, LogsState> {
  LogsBloc() : super(LogsState()) {
    on<GetLogsEvent>(_getLogsEvent);
  }

  Future<void> _getLogsEvent(
    GetLogsEvent event,
    Emitter<LogsState> emit,
  ) async {
    final req = await ApiService.getUserLogs(userId: event.userId);
    if (req.status) {
      emit(
        state.copyWith(
          logs: req.loglist,
          logsPageStatus: LogsPageState.success,
        ),
      );
      return;
    }

    state.copyWith(logsPageStatus: LogsPageState.fail);
    return;
  }
}
