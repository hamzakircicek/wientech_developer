import 'package:wien_tech_admin/models/post_model.dart';

enum PostPageStatus { loading, fail, success }

enum ProfilePostPageStatus { loading, fail, success }

class PostPageState {
  final int? currentPage;
  final PostPageStatus? pageStatus;
  final ProfilePostPageStatus? profilePageStatus;
  final List<Post>? postList;
  final List<Post>? postListUserBase;
  const PostPageState({
    this.currentPage = 0,
    this.profilePageStatus = ProfilePostPageStatus.loading,
    this.pageStatus = PostPageStatus.loading,
    this.postList = const [],
    this.postListUserBase = const [],
  });

  PostPageState copyWith({
    int? currentPage,
    PostPageStatus? pageStatus,
    ProfilePostPageStatus? profilePageStatus,
    List<Post>? postList,
    List<Post>? postListUserBase,
  }) {
    return PostPageState(
      profilePageStatus: profilePageStatus ?? this.profilePageStatus,
      pageStatus: pageStatus ?? this.pageStatus,
      currentPage: currentPage ?? this.currentPage,
      postList: postList ?? this.postList,
      postListUserBase: postListUserBase ?? this.postListUserBase,
    );
  }
}
