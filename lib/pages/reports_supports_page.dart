import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/bloc/report_support_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/report_support_bloc/event.dart';
import 'package:wien_tech_admin/bloc/report_support_bloc/state.dart';
import 'package:wien_tech_admin/widgets/report_widget.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getReports();
  }

  Future<void> _getReports() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReportsSupportsPageBloc>().add(GetReportsEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsSupportsPageBloc, ReportsPageState>(
      builder: (context, state) {
        if (state.pageStatus == ReportsPageStatus.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.pageStatus == ReportsPageStatus.fail) {
          return Center(child: Text('Bir hata oluştu'));
        } else {
          return ListView.builder(
            itemCount: state.reportList!.length,
            itemBuilder: (context, index) =>
                ReportWidget(report: state.reportList![index]),
          );
        }
      },
    );
  }
}
