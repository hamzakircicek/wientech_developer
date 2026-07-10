import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/bloc/post_page_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/post_page_bloc/event.dart';
import 'package:wien_tech_admin/bloc/post_page_bloc/state.dart';
import 'package:wien_tech_admin/models/user_model.dart';

class UserPosts extends StatefulWidget {
  final User user;

  const UserPosts({super.key, required this.user});

  @override
  State<UserPosts> createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts();
  }

  void getPosts() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostPageBloc>().add(
        GetPostsUserBaseEvent(userId: widget.user.id),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.user.userName)),
      body: BlocBuilder<PostPageBloc, PostPageState>(
        builder: (context, state) {
          if (state.profilePageStatus == ProfilePostPageStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.profilePageStatus == ProfilePostPageStatus.fail) {
            return Center(child: Text('Bir sorun olustu'));
          } else {
            return GridView.builder(
              itemCount: state.postListUserBase!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),

              itemBuilder: (ctx, index) => CachedNetworkImage(
                fit: BoxFit.cover,
                placeholder: (c, _) => const SizedBox(),
                cacheKey: state.postListUserBase![index].mediaList[0].cdnKey,
                imageUrl: state.postListUserBase![index].mediaList[0].cdnUrl,
                errorWidget: (context, url, error) =>
                    Icon(Icons.broken_image, color: Colors.grey),
              ),
            );
          }
        },
      ),
    );
  }
}
