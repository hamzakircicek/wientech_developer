abstract class RegisterEvent {}

class RegisterAdminEvent extends RegisterEvent {
  String userName;
  String password;
  RegisterAdminEvent({required this.userName, required this.password});
}
