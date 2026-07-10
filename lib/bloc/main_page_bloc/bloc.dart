import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/bloc/main_page_bloc/event.dart';
import 'package:wien_tech_admin/bloc/main_page_bloc/state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageBloc() : super(MainPageState()) {
    on<ChangePageEvent>(_changePageEvent);
  }

  void _changePageEvent(ChangePageEvent event, Emitter<MainPageState> emit) {
    emit(state.copyWith(currentPage: event.pageIndex));
  }

  // Future<void> _getPosts(GetPosts event, Emitter<MainPageState> emit) async {
  //   final req = await ApiService.getPosts();
  //   if (req.status) {
  //     emit(state.copyWith(pageStatus: PostPageStatus.success));
  //     return;
  //   }

  //   emit(state.copyWith(pageStatus: PostPageStatus.fail));
  //   return;
  // }
}
