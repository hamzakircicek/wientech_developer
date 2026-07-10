import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/api_services/api_service.dart';
import 'package:wien_tech_admin/bloc/bios_bloc/event.dart';
import 'package:wien_tech_admin/bloc/bios_bloc/state.dart';
import 'package:wien_tech_admin/models/bio_model.dart';

class BiosBloc extends Bloc<BiosEvent, BiosState> {
  BiosBloc() : super(BiosState()) {
    on<GetBios>(_getBios);

    on<RemoveBioEvent>(_removeBio);
  }

  Future<void> _getBios(GetBios event, Emitter<BiosState> emit) async {
    final req = await ApiService.getBioList();
    if (req.status) {
      emit(
        state.copyWith(pageStatus: BiosStatus.success, bioList: req.bioList),
      );
      return;
    }

    emit(state.copyWith(pageStatus: BiosStatus.fail));
    return;
  }

  Future<void> _removeBio(RemoveBioEvent event, Emitter<BiosState> emit) async {
    final req = await ApiService.removeBio(userId: event.userId);
    if (req) {
      final oldBioList = List<Bio>.from(state.bioList ?? []);
      final i = oldBioList.indexWhere((e) => e.user.id == event.userId);
      if (i == -1) return;
      oldBioList.removeAt(i);
      emit(state.copyWith(pageStatus: BiosStatus.success, bioList: oldBioList));
      return;
    }

    emit(state.copyWith(pageStatus: BiosStatus.fail));
    return;
  }
}
