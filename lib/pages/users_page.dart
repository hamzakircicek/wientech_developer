import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/bloc/users_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/users_bloc/event.dart';
import 'package:wien_tech_admin/bloc/users_bloc/state.dart';
import 'package:wien_tech_admin/widgets/user_cart.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UsersPageBloc>().add(GetUsers());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersPageBloc, UsersPageState>(
      builder: (context, state) {
        if (state.status == UserPageStatus.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.status == UserPageStatus.failure) {
          return Center(child: Text('bir hata oluştu'));
        } else {
          return ListView.builder(
            itemCount: state.userList!.length,
            itemBuilder: (context, index) =>
                UserCart(user: state.userList![index]),
          );
        }
      },
    );
  }
}
