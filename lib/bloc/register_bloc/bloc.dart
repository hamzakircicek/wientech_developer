import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/api_services/api_service.dart';

import 'package:wien_tech_admin/bloc/register_bloc/event.dart';
import 'package:wien_tech_admin/bloc/register_bloc/state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState()) {
    on<RegisterAdminEvent>(_registerUser);
  }

  Future<void> _registerUser(
    RegisterAdminEvent event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      emit(state.copyWith(registerStatus: RegisterStatus.loading));
      final registerRes = await ApiService.register(
        userName: event.userName,
        pass: event.password,
      );
      if (registerRes) {
        emit(state.copyWith(registerStatus: RegisterStatus.success));
        return;
      }
      emit(state.copyWith(registerStatus: RegisterStatus.fail));
    } catch (e, st) {
      print(st.toString());
      emit(state.copyWith(registerStatus: RegisterStatus.fail));
    }
  }
}
