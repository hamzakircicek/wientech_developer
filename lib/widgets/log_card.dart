import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wien_tech_admin/models/log_model.dart';

class LogCart extends StatelessWidget {
  final Log log;
  const LogCart({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat(
      'dd.MM.yyyy HH:mm',
    ).format(DateTime.parse(log.cratedAt).toLocal());
    return Container(
      margin: EdgeInsets.all(10),
      height: 100,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 238, 238, 238),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Kullanıcı idsi: ${log.userId}'),
            Text('Log Tipi: ${log.event}'),
            Text('Log ipsi: ${log.ipAdress}'),

            Text('Log Tarihi: $formattedDate'),
          ],
        ),
      ),
    );
  }
}
