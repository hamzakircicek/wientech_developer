import 'package:wien_tech_admin/models/media_model.dart';
import 'package:wien_tech_admin/models/user_model.dart';

class PostModel {
  final bool status;
  final List<Post> postList;
  final Cursor? cursor;
  final bool hasMore;
  PostModel({
    required this.status,
    required this.postList,
    this.cursor,
    required this.hasMore,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      status: json['status'] ?? false,
      postList: getPostList(json['posts']),
      cursor: json['nextCursor'] == null
          ? null
          : Cursor.fromJson(json['nextCursor']),
      hasMore: json['hasMore'] ?? false,
    );
  }

  static List<Post> getPostList(List json) =>
      json.map((e) => Post.fromJson(e)).toList();
}

class Post {
  String postId;
  User user;
  List<MediaModel> mediaList;
  String postMessage;
  String createdAt;

  Post({
    required this.postId,
    required this.user,
    required this.mediaList,
    required this.postMessage,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['_id'],
      user: User.fromJson(json['user']),
      mediaList: getMediaList(json['mediaList']),
      postMessage: json['post_message'],
      createdAt: json['createdAt'],
    );
  }

  static List<MediaModel> getMediaList(List json) =>
      json.map((e) => MediaModel.fromJson(e)).toList();
}
