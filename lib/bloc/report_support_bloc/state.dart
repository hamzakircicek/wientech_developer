import 'package:wien_tech_admin/models/reports_model.dart';
import 'package:wien_tech_admin/models/supports_model.dart';

enum ReportsPageStatus { loading, fail, success }

class ReportsPageState {
  final ReportsPageStatus? pageStatus;
  final List<Report>? reportList;

  final int? currentPage;
  const ReportsPageState({
    this.currentPage = 0,

    this.pageStatus = ReportsPageStatus.loading,
    this.reportList = const [],
  });

  ReportsPageState copyWith({
    int? currentPage,
    ReportsPageStatus? pageStatus,
    List<Report>? reportList,
  }) {
    return ReportsPageState(
      currentPage: currentPage ?? this.currentPage,

      pageStatus: pageStatus ?? this.pageStatus,
      reportList: reportList ?? this.reportList,
    );
  }
}
