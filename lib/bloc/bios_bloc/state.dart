import 'package:wien_tech_admin/models/bio_model.dart';

enum BiosStatus { loading, fail, success }

class BiosState {
  final BiosStatus? pageStatus;
  final List<Bio>? bioList;
  const BiosState({
    this.pageStatus = BiosStatus.loading,
    this.bioList = const [],
  });

  BiosState copyWith({BiosStatus? pageStatus, List<Bio>? bioList}) {
    return BiosState(
      pageStatus: pageStatus ?? this.pageStatus,
      bioList: bioList ?? this.bioList,
    );
  }
}
