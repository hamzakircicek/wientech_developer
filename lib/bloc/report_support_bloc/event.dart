abstract class ReportsPageEvent {}

class GetReportsEvent extends ReportsPageEvent {}

class ChangePageReportSupportEvent extends ReportsPageEvent {
  final int currentPage;
  ChangePageReportSupportEvent({required this.currentPage});
}
