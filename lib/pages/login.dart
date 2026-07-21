import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/bloc/login_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/login_bloc/event.dart';
import 'package:wien_tech_admin/bloc/login_bloc/state.dart';
import 'package:wien_tech_admin/pages/register.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    TextEditingController userNameController = TextEditingController();
    TextEditingController passController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text('Giriş Yap')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          children: [
            TextField(controller: userNameController),
            TextField(controller: passController),
            ElevatedButton(
              onPressed: () {
                loginBloc.add(
                  LoginAdminEvent(
                    context: context,
                    userName: userNameController.text,
                    password: passController.text,
                  ),
                );
              },
              child: loginBloc.state.loginStatus == LoginStatus.loading
                  ? Center(child: CircularProgressIndicator())
                  : Center(child: Text('Giriş Yap')),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => Register()),
                );
              },
              child: Center(child: Text('Kayıt Ol')),
            ),
          ],
        ),
      ),
    );
  }
}
