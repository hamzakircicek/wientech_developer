class LoginCheckModel {
  final String? adminId;
  final bool status;

  LoginCheckModel({this.adminId, required this.status});

  factory LoginCheckModel.fromJson(Map<String, dynamic> json) {
    return LoginCheckModel(
      adminId: json['admin_id'] ?? '',
      status: json['status'],
    );
  }
}
