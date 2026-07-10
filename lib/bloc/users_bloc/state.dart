import 'package:wien_tech_admin/models/user_model.dart';

enum UserPageStatus { loading, success, failure }

class UsersPageState {
  final List<User>? userList;
  final UserPageStatus? status;
  const UsersPageState({
    this.userList = const [],
    this.status = UserPageStatus.loading,
  });

  UsersPageState copyWith({List<User>? userList, UserPageStatus? status}) {
    return UsersPageState(
      userList: userList ?? this.userList,
      status: status ?? this.status,
    );
  }
}
