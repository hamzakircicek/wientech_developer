import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/bloc/support_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/support_bloc/event.dart';
import 'package:wien_tech_admin/bloc/support_bloc/state.dart';
import 'package:wien_tech_admin/models/supports_model.dart';

class SupportsPage extends StatefulWidget {
  final String? userId;
  const SupportsPage({super.key, this.userId});

  @override
  State<SupportsPage> createState() => _SupportsPageState();
}

class _SupportsPageState extends State<SupportsPage> {
  final ScrollController _sController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final supportBloc = context.read<SupportBloc>();
      supportBloc.add(GetSupportsEvent(userId: widget.userId));

      _sController.addListener(() {
        if (_sController.position.atEdge &&
            _sController.position.pixels != 0 &&
            supportBloc.state.hasMore) {
          supportBloc.add(
            LoadMoreEvent(
              cursor: supportBloc.state.cursor,
              userId: widget.userId,
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Destek Taleplerim', style: TextStyle(fontSize: 14)),
      ),
      body: BlocBuilder<SupportBloc, SupportState>(
        builder: (context, state) {
          if (state.loadingStatus == SupportLoadingStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.loadingStatus == SupportLoadingStatus.failure) {
            return Center(child: Text('Bir sorun olustu'));
          } else {
            return _supportsList(state.supports, state.hasMore);
          }
        },
      ),
    );
  }

  Widget _supportsList(List<SupportModel> supportslist, bool hasMore) {
    return ListView.separated(
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      controller: _sController,
      itemCount: supportslist.length,
      itemBuilder: (context, index) {
        if (index + 1 == supportslist.length && hasMore) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  color: Colors.black,
                ),
              ),
            ),
          );
        }
        return _supportsWidget(supportslist[index]);
      },
    );
  }

  Widget _supportsWidget(SupportModel support) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(typeParseSupportType(support.type)),
              Container(
                decoration: BoxDecoration(
                  color: getStatusColor(support.supportStatus),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 2,
                  ),
                  child: Center(
                    child: Text(typeParseSupportStatus(support.supportStatus)),
                  ),
                ),
              ),
            ],
          ),
          Text(support.message),
        ],
      ),
    );
  }

  String typeParseSupportType(SupportType type) {
    switch (type) {
      case SupportType.premium:
        return 'Premium ve Ödeme Sorunları';
      case SupportType.account:
        return 'Hesap ve Giriş Sorunları';
      case SupportType.post:
        return 'Gönderi ve İçerik Sorunları';
      case SupportType.security:
        return 'Güvenlik Sorunları';
      case SupportType.message:
        return 'Mesajlaşma Sorunları';
      case SupportType.profile:
        return 'Profil Sorunları';
      case SupportType.technic:
        return 'Teknik Sorun';
      case SupportType.suggestion:
        return 'Öneri ve Geri Bildirim';
      case SupportType.initial:
        return '';
    }
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

  Color getStatusColor(SupportStatus status) {
    switch (status) {
      case SupportStatus.pending:
        return Colors.grey.withAlpha(80);
      case SupportStatus.rejected:
        return Colors.red.withAlpha(100);
      case SupportStatus.solved:
        return Colors.greenAccent.withAlpha(100);
    }
  }
}
