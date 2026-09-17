import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/api_services/api_service.dart';
import 'package:wien_tech_admin/api_services/secure_storage_serv%C4%B1ce.dart';
import 'package:wien_tech_admin/bloc/login_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/login_bloc/event.dart';
import 'package:wien_tech_admin/bloc/login_bloc/state.dart';
import 'package:wien_tech_admin/bloc/main_page_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/main_page_bloc/event.dart';
import 'package:wien_tech_admin/models/logon_check_model.dart';
import 'package:wien_tech_admin/pages/main_page.dart';
import 'package:wien_tech_admin/pages/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      final LoginCheckModel lCheck = await ApiService.loginCheck();
      if (lCheck.status) {
        print('gelen iddd');
        print(lCheck.adminId!);
        await UserSecureStorageService.saveMyId(lCheck.adminId!);
        context.read<MainPageBloc>().add(
          AddAdminIdEvent(adminId: lCheck.adminId!),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (ctx) => MainPage()),
        );
      }
    });
  }

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
