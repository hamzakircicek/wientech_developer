enum LoginStatus { loading, initial, fail, success }

class LoginState {
  final LoginStatus? loginStatus;

  const LoginState({this.loginStatus = LoginStatus.initial});

  LoginState copyWith({LoginStatus? loginStatus}) {
    return LoginState(loginStatus: loginStatus ?? this.loginStatus);
  }
}
