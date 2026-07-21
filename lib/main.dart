import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/bloc/bios_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/login_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/logs_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/main_page_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/post_page_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/profile_photos_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/register_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/report_support_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/support_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/users_bloc/bloc.dart';
import 'package:wien_tech_admin/firebase_options.dart';
import 'package:wien_tech_admin/pages/login.dart';
import 'package:wien_tech_admin/pages/main_page.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const WienTechAdmin());
}

class WienTechAdmin extends StatelessWidget {
  const WienTechAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MainPageBloc()),
        BlocProvider(create: (_) => UsersPageBloc()),
        BlocProvider(create: (_) => LogsBloc()),
        BlocProvider(create: (_) => PostPageBloc()),
        BlocProvider(create: (_) => ProfilePhotoBloc()),
        BlocProvider(create: (_) => BiosBloc()),
        BlocProvider(create: (_) => RegisterBloc()),
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => SupportBloc()),
        BlocProvider(create: (_) => ReportsSupportsPageBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),

        home: LoginPage(),
      ),
    );
  }
}
