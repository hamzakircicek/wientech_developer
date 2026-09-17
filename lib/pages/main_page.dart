import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/api_services/firebase_services.dart';
import 'package:wien_tech_admin/api_services/secure_storage_serv%C4%B1ce.dart';
import 'package:wien_tech_admin/bloc/main_page_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/main_page_bloc/event.dart';
import 'package:wien_tech_admin/bloc/main_page_bloc/state.dart';
import 'package:wien_tech_admin/pages/new_bios_page.dart';
import 'package:wien_tech_admin/pages/new_profile_photos.dart';
import 'package:wien_tech_admin/pages/posts_page.dart';
import 'package:wien_tech_admin/pages/reports_supports_page.dart';
import 'package:wien_tech_admin/pages/supports_page.dart';
import 'package:wien_tech_admin/pages/users_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<BottomNavigationBarItem> items(BuildContext context) {
    final adminId = context.read<MainPageBloc>().state.adminId;
    print('addddddminiddddd');
    print(adminId);
    final isSpecialAdmin = adminId != '6aab255b26c10b0ab96fc625';
    return [
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Kullanıcılar'),
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Post'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Pp'),
      BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Bio'),
      if (isSpecialAdmin)
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_document),
          label: 'Rapor',
        ),

      if (isSpecialAdmin)
        BottomNavigationBarItem(
          icon: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: (const Color.fromARGB(255, 75, 75, 75)).withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.contact_support,
              color: const Color.fromARGB(255, 27, 27, 27),
              size: 21,
            ),
          ),
          label: 'Destek',
        ),
    ];
  }

  List<Widget> pages(BuildContext context) => [
    UsersPage(),
    PostsPage(),
    NewProfilePhotosPage(),
    NewBiosPage(),
    if (context.read<MainPageBloc>().state.adminId! !=
        '6aab255b26c10b0ab96fc625')
      ReportsPage(),
    if (context.read<MainPageBloc>().state.adminId! !=
        '6aab255b26c10b0ab96fc625')
      SupportsPage(),
  ];

  List<String> appBarTitles(BuildContext context) => [
    'Kullanıcılar',
    'Post',
    'Pp',
    'Bio',
    if (context.read<MainPageBloc>().state.adminId! !=
        '6aab255b26c10b0ab96fc625')
      'Rapor',
    if (context.read<MainPageBloc>().state.adminId! !=
        '6aab255b26c10b0ab96fc625')
      'Destek',
  ];
  late final String? myId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initFirebaseServices();
  }

  Future<void> initFirebaseServices() async {
    myId = await UserSecureStorageService.getMyId() ?? '';
    print(myId);
    await FirebaseNotificationService.init(adminId: myId!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageBloc, MainPageState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(
            appBarTitles(context)[state.currentPage ?? 0],
            style: TextStyle(fontSize: 14),
          ),
        ),
        body: pages(context)[state.currentPage ?? 0],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(fontSize: 12),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          currentIndex: state.currentPage ?? 0,
          onTap: (value) {
            context.read<MainPageBloc>().add(ChangePageEvent(pageIndex: value));
          },
          items: items(context),
        ),
      ),
    );
  }
}
