import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wien_tech_admin/models/user_model.dart';
import 'package:wien_tech_admin/pages/user_detail_page.dart';

class UserCart extends StatelessWidget {
  final User user;
  const UserCart({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserDetailPage(user: user)),
      ),
      child: Container(
        margin: EdgeInsets.all(10),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 238, 238, 238),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Container(
                height: 60,
                width: 60,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('İsim: ${user.userName}'),
                  Text('Id: ${user.id}'),
                  Text('Bio: ${user.bio}'),
                  Text('Yaş: ${user.age}'),
                  Text('Cinsiyet: ${user.gender}'),
                ],
              ),
              Text(user.isDeleted ? 'Silindi' : 'Aktif'),
            ],
          ),
        ),
      ),
    );
  }
}
