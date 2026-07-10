abstract class PostPageEvent {}

class GetPosts extends PostPageEvent {}

class GetPostsUserBaseEvent extends PostPageEvent {
  String? userId;
  GetPostsUserBaseEvent({this.userId});
}

class RemovePostEvent extends PostPageEvent {
  final String postId;
  RemovePostEvent({required this.postId});
}
