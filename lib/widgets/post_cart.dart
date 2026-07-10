import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wien_tech_admin/bloc/post_page_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/post_page_bloc/event.dart';
import 'package:wien_tech_admin/models/post_model.dart';
import 'package:wien_tech_admin/pages/user_detail_page.dart';

class PostCart extends StatelessWidget {
  final Post post;
  const PostCart({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat(
      'dd.MM.yyyy HH:mm',
    ).format(DateTime.parse(post.createdAt).toLocal());
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => UserDetailPage(user: post.user),
        ),
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: 400,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 238, 238, 238),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        spacing: 10,
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
                                cacheKey: post.user.profilePhotoKey,
                                imageUrl: post.user.profilePhotoUrl,
                                errorWidget: (context, url, error) => Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(post.user.userName),
                              Text(post.user.id),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemCount: post.mediaList.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                placeholder: (c, _) => const SizedBox(),
                                cacheKey: post.mediaList[index].cdnKey,
                                imageUrl: post.mediaList[index].cdnUrl,
                                errorWidget: (context, url, error) => Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(formattedDate),
                ],
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: InkWell(
              onTap: () async {
                context.read<PostPageBloc>().add(
                  RemovePostEvent(postId: post.postId),
                );
              },
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3.0,
                    horizontal: 10,
                  ),
                  child: Row(
                    spacing: 5,
                    children: [
                      Icon(Icons.close, color: Colors.white, size: 15),
                      Text(
                        'Sil',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
