import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/api_services/api_service.dart';
import 'package:wien_tech_admin/bloc/login_bloc/event.dart';
import 'package:wien_tech_admin/bloc/login_bloc/state.dart';
import 'package:wien_tech_admin/pages/main_page.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginAdminEvent>(_loginAdmin);
  }

  Future<void> _loginAdmin(
    LoginAdminEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(loginStatus: LoginStatus.loading));
      final registerRes = await ApiService.login(
        userName: event.userName,
        pass: event.password,
      );
      if (registerRes.status) {
        emit(state.copyWith(loginStatus: LoginStatus.success));
        Navigator.push(
          event.context,
          MaterialPageRoute(builder: (ctx) => MainPage()),
        );
        return;
      }
      emit(state.copyWith(loginStatus: LoginStatus.fail));
    } catch (e, st) {
      print(st.toString());
      emit(state.copyWith(loginStatus: LoginStatus.fail));
    }
  }
}
