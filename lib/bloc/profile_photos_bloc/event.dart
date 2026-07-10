abstract class ProfilePhotoEvent {}

class GetProfilePhotoListEvent extends ProfilePhotoEvent {}

class RemoveProfilePhotoEvent extends ProfilePhotoEvent {
  final String userId;
  final String cdnKey;
  RemoveProfilePhotoEvent({required this.userId, required this.cdnKey});
}
