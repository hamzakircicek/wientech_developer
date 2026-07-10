import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/api_services/api_service.dart';
import 'package:wien_tech_admin/bloc/post_page_bloc/event.dart';
import 'package:wien_tech_admin/bloc/post_page_bloc/state.dart';
import 'package:wien_tech_admin/models/post_model.dart';

class PostPageBloc extends Bloc<PostPageEvent, PostPageState> {
  PostPageBloc() : super(PostPageState()) {
    on<GetPosts>(_getPosts);
    on<GetPostsUserBaseEvent>(_getPostsUserBase);
    on<RemovePostEvent>(_removePostFromPostList);
  }

  Future<void> _getPosts(GetPosts event, Emitter<PostPageState> emit) async {
    final req = await ApiService.getPosts();
    if (req.status) {
      emit(
        state.copyWith(
          pageStatus: PostPageStatus.success,
          postList: req.postList,
        ),
      );
      return;
    }

    emit(state.copyWith(pageStatus: PostPageStatus.fail));
    return;
  }

  Future<void> _getPostsUserBase(
    GetPostsUserBaseEvent event,
    Emitter<PostPageState> emit,
  ) async {
    final req = await ApiService.getPosts(userId: event.userId);
    if (req.status) {
      emit(
        state.copyWith(
          profilePageStatus: ProfilePostPageStatus.success,
          postListUserBase: req.postList,
        ),
      );
      return;
    }

    state.copyWith(profilePageStatus: ProfilePostPageStatus.fail);
    return;
  }

  Future<void> _removePostFromPostList(
    RemovePostEvent event,
    Emitter<PostPageState> emit,
  ) async {
    final req = await ApiService.removePost(postId: event.postId);
    if (req) {
      final oldPostList = List<Post>.from(state.postList ?? []);
      final i = oldPostList.indexWhere((e) => e.postId == event.postId);
      if (i == -1) return;
      oldPostList.removeAt(i);
      emit(
        state.copyWith(
          pageStatus: PostPageStatus.success,
          postList: oldPostList,
        ),
      );
      return;
    }

    emit(state.copyWith(pageStatus: PostPageStatus.fail));
    return;
  }
}
