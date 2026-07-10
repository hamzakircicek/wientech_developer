import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/bloc/logs_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/logs_bloc/event.dart';
import 'package:wien_tech_admin/bloc/logs_bloc/state.dart';
import 'package:wien_tech_admin/widgets/log_card.dart';

class LogsPage extends StatefulWidget {
  final String userId;
  const LogsPage({super.key, required this.userId});

  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLogs();
  }

  void getLogs() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LogsBloc>().add(GetLogsEvent(userId: widget.userId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Loglar', style: TextStyle(fontSize: 14))),
      body: BlocBuilder<LogsBloc, LogsState>(
        builder: (context, state) {
          if (state.logsPageStatus == LogsPageState.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.logsPageStatus == LogsPageState.fail) {
            return Center(child: Text('Bir sorun oluştu'));
          } else {
            return ListView.builder(
              itemCount: state.logs!.length,
              itemBuilder: (context, index) => LogCart(log: state.logs![index]),
            );
          }
        },
      ),
    );
  }
}
