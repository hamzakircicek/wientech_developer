import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/api_services/api_service.dart';
import 'package:wien_tech_admin/bloc/users_bloc/event.dart';
import 'package:wien_tech_admin/bloc/users_bloc/state.dart';

class UsersPageBloc extends Bloc<UsersPageEvent, UsersPageState> {
  UsersPageBloc() : super(UsersPageState()) {
    on<GetUsers>(_getUsers);
  }

  Future<void> _getUsers(GetUsers event, Emitter<UsersPageState> emit) async {
    final req = await ApiService.getUsers();
    if (req.status) {
      emit(
        state.copyWith(userList: req.userlist, status: UserPageStatus.success),
      );
      return;
    }

    emit(state.copyWith(status: UserPageStatus.failure));
    return;
  }
}
