import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wien_tech_admin/api_services/api_service.dart';
import 'package:wien_tech_admin/bloc/main_page_bloc/bloc.dart';
import 'package:wien_tech_admin/models/user_model.dart';
import 'package:wien_tech_admin/pages/logs_page.dart';
import 'package:wien_tech_admin/pages/supports_page.dart';
import 'package:wien_tech_admin/pages/user_posts.dart';

class UserDetailPage extends StatelessWidget {
  final User user;
  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final adminId = context.read<MainPageBloc>().state.adminId;

    final isSpecialAdmin = adminId == '6aab255b26c10b0ab96fc625';

    final isFemale = user.gender == 'female';
    final canShowImages = isSpecialAdmin || !isFemale;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.userName, style: TextStyle(fontSize: 14)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  if (canShowImages)
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          placeholder: (c, _) => const SizedBox(),
                          cacheKey: user.profilePhotoKey,
                          imageUrl: user.profilePhotoUrl,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                    ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {},
                    child: Text(
                      'Profil Fotografini Sil',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (user.bio.isNotEmpty)
                    SizedBox(
                      width: 400,
                      child: Text(
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,

                        'Biyografi: ${user.bio}',
                      ),
                    ),
                  if (user.bio.isNotEmpty)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {},
                      child: Text(
                        'Bioyu Sil',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                ],
              ),

              SizedBox(
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    final res = await ApiService.removeUserName(
                      userId: user.id,
                    );
                    if (res) {
                      Fluttertoast.showToast(
                        backgroundColor: const Color.fromARGB(
                          238,
                          224,
                          224,
                          224,
                        ),
                        textColor: Colors.black,
                        fontSize: 14,
                        msg: 'Isim başarıyla silindi',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                      );
                    }
                  },
                  child: Text(
                    'Kullanıcı ismini sil',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              SizedBox(
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    final res = await ApiService.banUser(userId: user.id);
                    if (res) {
                      Fluttertoast.showToast(
                        backgroundColor: const Color.fromARGB(
                          238,
                          224,
                          224,
                          224,
                        ),
                        textColor: Colors.black,
                        fontSize: 14,
                        msg: 'Kullanici banlandi',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                      );
                    }
                  },
                  child: Text(
                    'Kullaniciyi Banla',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    final res = await ApiService.removeBanUser(userId: user.id);
                    if (res) {
                      Fluttertoast.showToast(
                        backgroundColor: const Color.fromARGB(
                          238,
                          224,
                          224,
                          224,
                        ),
                        textColor: Colors.black,
                        fontSize: 14,
                        msg: 'Kullanici bani kaldirildi',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                      );
                    }
                  },
                  child: Text(
                    'Kullanici Banini Kaldir',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Hesap Durumu:'),
                    Text(user.isDeleted ? 'Silindi' : 'Aktif'),
                  ],
                ),
              ),

              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: _userPageContainlist(
                    context,
                    canShowImages,
                  ).length,
                  itemBuilder: (context, index) =>
                      _userPageContainlist(context, canShowImages)[index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _userPageContainlist(BuildContext context, bool canShow) {
    return [
      if (canShow)
        _userPageContainCart(
          color: Colors.pink.withOpacity(0.5),
          text: 'Paylaşımlar',
          icon: Icons.photo,
          func: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserPosts(user: user)),
            );
          },
        ),
      _userPageContainCart(
        color: Colors.blue.withOpacity(0.5),
        text: 'Loglar',
        icon: Icons.sign_language_outlined,
        func: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LogsPage(userId: user.id)),
          );
        },
      ),
      _userPageContainCart(
        color: Colors.orange.withOpacity(0.5),
        text: 'Raporlar',
        icon: Icons.report,
      ),

      _userPageContainCart(
        color: const Color.fromARGB(255, 38, 226, 148).withOpacity(0.5),
        text: 'Destek Talepleri',
        icon: Icons.contact_support,
        func: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SupportsPage(userId: user.id),
            ),
          );
        },
      ),
    ];
  }

  Widget _userPageContainCart({
    required String text,
    required IconData icon,
    required Color color,
    Function? func,
  }) {
    return InkWell(
      onTap: func != null
          ? () {
              func();
            }
          : null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
          ),
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              Text(text, style: TextStyle(fontSize: 15, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
