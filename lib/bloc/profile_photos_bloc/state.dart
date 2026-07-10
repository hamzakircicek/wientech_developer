import 'package:wien_tech_admin/models/profile_photo_model.dart';

enum ProfilePhotoStatus { loading, fail, success }

class ProfilePhotoState {
  final ProfilePhotoStatus? pageStatus;
  final List<ProfilePhoto>? profilePhotoList;
  const ProfilePhotoState({
    this.pageStatus = ProfilePhotoStatus.loading,
    this.profilePhotoList = const [],
  });

  ProfilePhotoState copyWith({
    ProfilePhotoStatus? pageStatus,
    List<ProfilePhoto>? profilePhotoList,
  }) {
    return ProfilePhotoState(
      pageStatus: pageStatus ?? this.pageStatus,
      profilePhotoList: profilePhotoList ?? this.profilePhotoList,
    );
  }
}
