import 'package:flutter/material.dart';
import 'package:wien_tech_admin/api_services/api_service.dart';
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
          ElevatedButton(
            onPressed: () async {
              final res = await ApiService.setReport(reportId: report.id);
              if (res) {
                print('rapor basariyla buncellendi');
              }
            },
            child: Center(child: Text('Raporu Guncelle')),
          ),
        ],
      ),
    );
  }
}
