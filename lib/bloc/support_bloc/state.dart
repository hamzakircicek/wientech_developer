import 'package:wien_tech_admin/models/supports_model.dart';

enum SupportLoadingStatus { loading, success, failure }

class SupportState {
  SupportLoadingStatus? loadingStatus;
  List<SupportModel> supports;

  String? type;
  bool loadingMore;
  bool hasMore;
  bool? sending;
  SupportCursor? cursor;
  SupportState({
    this.type,

    this.supports = const [],
    this.loadingStatus = SupportLoadingStatus.loading,
    this.hasMore = false,
    this.sending = false,
    this.loadingMore = false,
    this.cursor,
  });

  SupportState copyWith({
    String? type,

    List<SupportModel>? supports,
    SupportLoadingStatus? loadingStatus,
    bool? hasMore,
    bool? sending,
    SupportCursor? cursor,
    bool? loadingMore,
  }) => SupportState(
    loadingStatus: loadingStatus ?? this.loadingStatus,
    type: type ?? this.type,
    supports: supports ?? this.supports,
    hasMore: hasMore ?? this.hasMore,
    sending: sending ?? false,
    loadingMore: loadingMore ?? false,
    cursor: cursor,
  );
}
