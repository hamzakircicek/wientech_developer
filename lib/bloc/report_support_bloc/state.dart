import 'package:wien_tech_admin/models/reports_model.dart';
import 'package:wien_tech_admin/models/supports_model.dart';

enum ReportsPageStatus { loading, fail, success }

class ReportsPageState {
  final ReportsPageStatus? pageStatus;
  final List<Report>? reportList;
  final List<Support>? supportList;
  final int? currentPage;
  const ReportsPageState({
    this.currentPage = 0,
    this.supportList = const [],
    this.pageStatus = ReportsPageStatus.loading,
    this.reportList = const [],
  });

  ReportsPageState copyWith({
    int? currentPage,
    ReportsPageStatus? pageStatus,
    List<Report>? reportList,
    List<Support>? supportList,
  }) {
    return ReportsPageState(
      currentPage: currentPage ?? this.currentPage,
      supportList: supportList ?? this.supportList,
      pageStatus: pageStatus ?? this.pageStatus,
      reportList: reportList ?? this.reportList,
    );
  }
}
