import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/api_services/api_service.dart';
import 'package:wien_tech_admin/bloc/support_bloc/event.dart';
import 'package:wien_tech_admin/bloc/support_bloc/state.dart';

class SupportBloc extends Bloc<SupportEvent, SupportState> {
  SupportBloc() : super(SupportState()) {
    on<ChangeSupportTypeEvent>(_changeSupportTypeEvent);

    on<ResetSupportEvent>(_resetSupportEvent);
    on<GetSupportsEvent>(_getSupports);
    on<LoadMoreEvent>(_loadMoreEvent);
  }

  Future<void> _getSupports(
    GetSupportsEvent event,
    Emitter<SupportState> emit,
  ) async {
    try {
      final req = await ApiService.getSupports(userId: event.userId);
      if (req.status) {
        emit(
          state.copyWith(
            loadingStatus: SupportLoadingStatus.success,
            supports: req.supports,
            hasMore: req.hasMore,
            cursor: req.cursor,
          ),
        );
        return;
      }

      emit(state.copyWith(loadingStatus: SupportLoadingStatus.failure));
    } catch (e, st) {
      emit(state.copyWith(loadingStatus: SupportLoadingStatus.failure));
      debugPrint(st.toString());
    }
  }

  void _changeSupportTypeEvent(
    ChangeSupportTypeEvent event,
    Emitter<SupportState> emit,
  ) {
    try {
      emit(state.copyWith(type: event.type));
    } catch (e) {}
  }

  Future<void> _loadMoreEvent(
    LoadMoreEvent event,
    Emitter<SupportState> emit,
  ) async {
    try {
      if (state.hasMore) {
        final req = await ApiService.getSupports(
          cursor: event.cursor,
          userId: event.userId,
        );
        if (req.status) {
          emit(
            state.copyWith(
              loadingStatus: SupportLoadingStatus.success,
              supports: [...state.supports, ...req.supports],
              hasMore: req.hasMore,
              cursor: req.cursor,
            ),
          );
          return;
        } else {
          emit(state.copyWith(loadingStatus: SupportLoadingStatus.failure));
        }
      }
    } catch (e, st) {
      emit(state.copyWith(loadingStatus: SupportLoadingStatus.failure));
      debugPrint(st.toString());
    }
  }

  void _resetSupportEvent(ResetSupportEvent event, Emitter<SupportState> emit) {
    emit(SupportState());
  }
}
