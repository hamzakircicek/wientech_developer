class LoginModel {
  final bool status;
  final String? token;

  LoginModel({required this.status, this.token});
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(status: json['status'], token: json['token']);
  }
}
