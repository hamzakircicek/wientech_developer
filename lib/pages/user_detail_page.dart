import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wien_tech_admin/api_services/api_service.dart';
import 'package:wien_tech_admin/models/user_model.dart';
import 'package:wien_tech_admin/pages/logs_page.dart';
import 'package:wien_tech_admin/pages/supports_page.dart';
import 'package:wien_tech_admin/pages/user_posts.dart';

class UserDetailPage extends StatelessWidget {
  final User user;
  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                height: 30,
                child: Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Biyografi: ${user.bio}'),
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
              ),

              SizedBox(
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    final res = await ApiService.banUser(userId: user.id);
                    if (res) {
                      print('ban basarili kral');
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
                      print('ban kaldirma islemi basarili kral');
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
                  itemCount: _userPageContainlist(context).length,
                  itemBuilder: (context, index) =>
                      _userPageContainlist(context)[index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _userPageContainlist(BuildContext context) {
    return [
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
