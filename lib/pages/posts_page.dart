import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/bloc/post_page_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/post_page_bloc/event.dart';
import 'package:wien_tech_admin/bloc/post_page_bloc/state.dart';
import 'package:wien_tech_admin/widgets/post_cart.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts();
  }

  void getPosts() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostPageBloc>().add(GetPosts());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostPageBloc, PostPageState>(
      builder: (context, state) {
        if (state.pageStatus == PostPageStatus.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.pageStatus == PostPageStatus.fail) {
          return Center(child: Text('Bir sorun oluştu'));
        } else {
          return ListView.builder(
            itemCount: state.postList!.length,
            itemBuilder: (context, index) =>
                PostCart(post: state.postList![index]),
          );
        }
      },
    );
  }
}
