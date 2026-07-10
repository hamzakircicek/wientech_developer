import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wien_tech_admin/models/bio_model.dart';
import 'package:wien_tech_admin/pages/user_detail_page.dart';

class BioWidget extends StatelessWidget {
  final Bio bio;
  final Function removeFunc;
  const BioWidget({super.key, required this.bio, required this.removeFunc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetailPage(user: bio.user),
            ),
          );
        },
        child: Container(
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
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              placeholder: (c, _) => const SizedBox(),
                              cacheKey: bio.user.profilePhotoKey,
                              imageUrl: bio.user.profilePhotoUrl,
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.broken_image, color: Colors.grey),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [Text(bio.user.userName), Text(bio.bio)],
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
            ],
          ),
        ),
      ),
    );
  }
}
