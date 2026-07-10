abstract class BiosEvent {}

class GetBios extends BiosEvent {}

class GetPostsUserBaseEvent extends BiosEvent {
  String? userId;
  GetPostsUserBaseEvent({this.userId});
}

class RemoveBioEvent extends BiosEvent {
  final String userId;
  RemoveBioEvent({required this.userId});
}
