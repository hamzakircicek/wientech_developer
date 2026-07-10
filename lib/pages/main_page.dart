import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/api_services/firebase_services.dart';
import 'package:wien_tech_admin/bloc/main_page_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/main_page_bloc/event.dart';
import 'package:wien_tech_admin/bloc/main_page_bloc/state.dart';
import 'package:wien_tech_admin/pages/new_bios_page.dart';
import 'package:wien_tech_admin/pages/new_profile_photos.dart';
import 'package:wien_tech_admin/pages/posts_page.dart';
import 'package:wien_tech_admin/pages/reports_supports_page.dart';
import 'package:wien_tech_admin/pages/users_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Kullanıcılar'),
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Paylaşımlar'),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profil Footoğrafları',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Biolar'),

    BottomNavigationBarItem(
      icon: Icon(Icons.edit_document),
      label: 'Rapor & Destek',
    ),
  ];

  final List<Widget> pages = [
    UsersPage(),
    PostsPage(),
    NewProfilePhotosPage(),
    NewBiosPage(),
    ReportsPage(),
  ];

  final List<String> appBarTitles = [
    'Kullanıcılar',
    'Paylaşımlar',
    'Profil Fotoğrafları',
    'Biolar',

    'Raporlar & Destek',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initFirebaseServices();
  }

  Future<void> initFirebaseServices() async {
    await FirebaseNotificationService.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageBloc, MainPageState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(
            appBarTitles[state.currentPage ?? 0],
            style: TextStyle(fontSize: 14),
          ),
        ),
        body: pages[state.currentPage ?? 0],
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
          items: items,
        ),
      ),
    );
  }
}
