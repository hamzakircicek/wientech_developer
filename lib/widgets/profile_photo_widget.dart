import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/bloc/main_page_bloc/bloc.dart';
import 'package:wien_tech_admin/models/profile_photo_model.dart';
import 'package:wien_tech_admin/pages/user_detail_page.dart';

class ProfilePhotoWidget extends StatelessWidget {
  final ProfilePhoto profilePhoto;
  final Function removeFunc;
  const ProfilePhotoWidget({
    super.key,
    required this.profilePhoto,
    required this.removeFunc,
  });

  @override
  Widget build(BuildContext context) {
    final adminId = context.read<MainPageBloc>().state.adminId;

    final isSpecialAdmin = adminId == '6aab255b26c10b0ab96fc625';

    final isFemale = profilePhoto.user.gender == 'female';
    final canShowImages = isSpecialAdmin || !isFemale;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetailPage(user: profilePhoto.user),
            ),
          );
        },
        child: Container(
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 239, 239, 239),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 10,
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        if (canShowImages)
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                placeholder: (c, _) => const SizedBox(),
                                cacheKey: profilePhoto.user.profilePhotoKey,
                                imageUrl: profilePhoto.user.profilePhotoUrl,
                                errorWidget: (context, url, error) => Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(profilePhoto.user.userName),
                            Text(profilePhoto.user.id),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        removeFunc();
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
              if (canShowImages)
                Expanded(
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    placeholder: (c, _) => const SizedBox(),
                    cacheKey: profilePhoto.user.profilePhotoKey,
                    imageUrl: profilePhoto.user.profilePhotoUrl,
                    errorWidget: (context, url, error) =>
                        Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),

              if (isFemale && !isSpecialAdmin) Text('Kadin Profil Fotografi'),
            ],
          ),
        ),
      ),
    );
  }
}
