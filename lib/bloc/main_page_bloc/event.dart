abstract class MainPageEvent {}

class ChangePageEvent extends MainPageEvent {
  int pageIndex;
  ChangePageEvent({required this.pageIndex});
}

class GetPosts extends MainPageEvent {}
