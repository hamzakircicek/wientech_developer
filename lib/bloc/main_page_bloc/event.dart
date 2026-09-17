abstract class MainPageEvent {}

class ChangePageEvent extends MainPageEvent {
  int pageIndex;
  ChangePageEvent({required this.pageIndex});
}

class AddAdminIdEvent extends MainPageEvent {
  String adminId;
  AddAdminIdEvent({required this.adminId});
}

class GetPosts extends MainPageEvent {}
