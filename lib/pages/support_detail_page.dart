import 'package:flutter/material.dart';
import 'package:wien_tech_admin/models/supports_model.dart';

class SupportDetailPage extends StatelessWidget {
  final SupportModel support;
  const SupportDetailPage({super.key, required this.support});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Destek Detay')),
      body: Column(
        children: [
          Text(support.user.userName),
          Text(support.user.userName),
          Text(typeParseSupportStatus(support.supportStatus)),
        ],
      ),
    );
  }

  String typeParseSupportStatus(SupportStatus status) {
    switch (status) {
      case SupportStatus.pending:
        return 'Inceleniyor';
      case SupportStatus.solved:
        return 'Cozumlendi';
      case SupportStatus.rejected:
        return 'Reddedildi';
    }
  }
}
