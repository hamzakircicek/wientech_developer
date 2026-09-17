class LoginModel {
  final bool status;
  final String? token;
  final String? adminId;

  LoginModel({required this.status, this.token, this.adminId});
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'],
      token: json['token'],
      adminId: json['admin_id'],
    );
  }
}
