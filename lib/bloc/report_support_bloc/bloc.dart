import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/api_services/api_service.dart';
import 'package:wien_tech_admin/bloc/report_support_bloc/event.dart';
import 'package:wien_tech_admin/bloc/report_support_bloc/state.dart';

class ReportsSupportsPageBloc extends Bloc<ReportsPageEvent, ReportsPageState> {
  ReportsSupportsPageBloc() : super(ReportsPageState()) {
    on<GetReportsEvent>(_getReportsEvent);
    on<GetSupportsEvent>(_getSupportsEvent);

    on<ChangePageReportSupportEvent>(_changePageReportSupportEvent);
  }

  Future<void> _getReportsEvent(
    GetReportsEvent event,
    Emitter<ReportsPageState> emit,
  ) async {
    try {
      emit(state.copyWith(pageStatus: ReportsPageStatus.loading));
      final req = await ApiService.getReports();
      if (req.status) {
        emit(
          state.copyWith(
            pageStatus: ReportsPageStatus.success,
            reportList: req.reportList,
          ),
        );
        return;
      }

      emit(state.copyWith(pageStatus: ReportsPageStatus.fail));
    } catch (e) {
      emit(state.copyWith(pageStatus: ReportsPageStatus.fail));
    }
  }

  Future<void> _getSupportsEvent(
    GetSupportsEvent event,
    Emitter<ReportsPageState> emit,
  ) async {
    try {
      emit(state.copyWith(pageStatus: ReportsPageStatus.loading));
      final req = await ApiService.getReports();
      if (req.status) {
        emit(
          state.copyWith(
            pageStatus: ReportsPageStatus.success,
            reportList: req.reportList,
          ),
        );
        return;
      }

      emit(state.copyWith(pageStatus: ReportsPageStatus.fail));
    } catch (e) {
      emit(state.copyWith(pageStatus: ReportsPageStatus.fail));
    }
  }

  void _changePageReportSupportEvent(
    ChangePageReportSupportEvent event,
    Emitter<ReportsPageState> emit,
  ) {
    emit(state.copyWith(currentPage: event.currentPage));
  }
}
