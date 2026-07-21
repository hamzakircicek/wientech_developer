enum RegisterStatus { loading, fail, initial, success }

class RegisterState {
  final RegisterStatus? registerStatus;

  const RegisterState({this.registerStatus = RegisterStatus.initial});

  RegisterState copyWith({RegisterStatus? registerStatus}) {
    return RegisterState(registerStatus: registerStatus ?? this.registerStatus);
  }
}
