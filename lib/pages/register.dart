import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/bloc/register_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/register_bloc/event.dart';
import 'package:wien_tech_admin/bloc/register_bloc/state.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final registerBloc = context.read<RegisterBloc>();
    TextEditingController userNameController = TextEditingController();
    TextEditingController passController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text('Admin Hesabı Oluştur')),
      body: Column(
        children: [
          TextField(controller: userNameController),
          TextField(controller: passController),
          ElevatedButton(
            onPressed: () {
              registerBloc.add(
                RegisterAdminEvent(
                  userName: userNameController.text,
                  password: passController.text,
                ),
              );
            },
            child: registerBloc.state.registerStatus == RegisterStatus.loading
                ? Center(child: CircularProgressIndicator())
                : Center(child: Text('Kaydet')),
          ),
        ],
      ),
    );
  }
}
