import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/api_services/api_service.dart';
import 'package:wien_tech_admin/bloc/profile_photos_bloc/event.dart';
import 'package:wien_tech_admin/bloc/profile_photos_bloc/state.dart';
import 'package:wien_tech_admin/models/profile_photo_model.dart';

class ProfilePhotoBloc extends Bloc<ProfilePhotoEvent, ProfilePhotoState> {
  ProfilePhotoBloc() : super(ProfilePhotoState()) {
    on<GetProfilePhotoListEvent>(_getProfilePhotos);

    on<RemoveProfilePhotoEvent>(_removeProfilePhotoEvent);
  }

  Future<void> _getProfilePhotos(
    GetProfilePhotoListEvent event,
    Emitter<ProfilePhotoState> emit,
  ) async {
    try {
      final req = await ApiService.getProfilePhotos();
      if (req.status) {
        emit(
          state.copyWith(
            pageStatus: ProfilePhotoStatus.success,
            profilePhotoList: req.profilePhotoList,
          ),
        );
        return;
      }

      emit(state.copyWith(pageStatus: ProfilePhotoStatus.fail));
      return;
    } catch (e, st) {
      debugPrint(st.toString());
      emit(state.copyWith(pageStatus: ProfilePhotoStatus.fail));
    }
  }

  Future<void> _removeProfilePhotoEvent(
    RemoveProfilePhotoEvent event,
    Emitter<ProfilePhotoState> emit,
  ) async {
    try {
      final req = await ApiService.removeProfilePhoto(
        userId: event.userId,
        mediaKey: event.cdnKey,
      );
      if (req) {
        final oldProfilePhotoList = List<ProfilePhoto>.from(
          state.profilePhotoList ?? [],
        );
        final i = oldProfilePhotoList.indexWhere(
          (e) => e.user.id == event.userId,
        );
        if (i == -1) return;
        oldProfilePhotoList.removeAt(i);
        emit(
          state.copyWith(
            pageStatus: ProfilePhotoStatus.success,
            profilePhotoList: oldProfilePhotoList,
          ),
        );
        return;
      }

      emit(state.copyWith(pageStatus: ProfilePhotoStatus.fail));
      return;
    } catch (e, st) {
      debugPrint(st.toString());
      emit(state.copyWith(pageStatus: ProfilePhotoStatus.fail));
    }
  }
}
