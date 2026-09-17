import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/bloc/main_page_bloc/bloc.dart';
import 'package:wien_tech_admin/models/user_model.dart';
import 'package:wien_tech_admin/pages/user_detail_page.dart';

class UserCart extends StatelessWidget {
  final User user;
  const UserCart({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final adminId = context.read<MainPageBloc>().state.adminId;

    final isSpecialAdmin = adminId == '6aab255b26c10b0ab96fc625';

    final isFemale = user.gender == 'female';
    final canShowImages = isSpecialAdmin || !isFemale;
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
              if (canShowImages)
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
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('İsim: ${user.userName}'),
                  Text('Id: ${user.id}'),
                  if (user.bio.isNotEmpty)
                    SizedBox(
                      width: 250,
                      child: Text(
                        'Bio: ${user.bio}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if (user.age.isNotEmpty) Text('Yaş: ${user.age}'),
                  Text(
                    'Cinsiyet: ${user.gender}',
                    style: TextStyle(
                      color: user.gender == "male"
                          ? Colors.blue
                          : const Color.fromARGB(255, 232, 76, 128),
                    ),
                  ),
                ],
              ),
              Text(
                user.isDeleted ? 'Silindi' : 'Aktif',
                style: TextStyle(
                  color: user.isDeleted
                      ? Colors.red
                      : const Color.fromARGB(255, 25, 132, 80),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
