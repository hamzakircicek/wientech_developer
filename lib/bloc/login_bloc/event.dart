import 'package:flutter/material.dart';

abstract class LoginEvent {}

class LoginAdminEvent extends LoginEvent {
  String userName;
  String password;
  BuildContext context;
  LoginAdminEvent({
    required this.userName,
    required this.password,
    required this.context,
  });
}
