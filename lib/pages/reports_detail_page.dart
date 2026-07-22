import 'package:flutter/material.dart';
import 'package:wien_tech_admin/models/reports_model.dart';

class ReportDetailPage extends StatelessWidget {
  final Report report;
  const ReportDetailPage({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rapor Detay')),
      body: Column(
        children: [
          Text(report.reporterUser.userName),
          Text(report.reportedUser.userName),
          Text(report.reportStatus),
        ],
      ),
    );
  }
}
