import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/bloc/profile_photos_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/profile_photos_bloc/event.dart';
import 'package:wien_tech_admin/bloc/profile_photos_bloc/state.dart';
import 'package:wien_tech_admin/widgets/profile_photo_widget.dart';

class NewProfilePhotosPage extends StatefulWidget {
  const NewProfilePhotosPage({super.key});

  @override
  State<NewProfilePhotosPage> createState() => _NewProfilePhotosPageState();
}

class _NewProfilePhotosPageState extends State<NewProfilePhotosPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfilePhotos();
  }

  void getProfilePhotos() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfilePhotoBloc>().add(GetProfilePhotoListEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePhotoBloc, ProfilePhotoState>(
      builder: (context, state) {
        if (state.pageStatus == ProfilePhotoStatus.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.pageStatus == ProfilePhotoStatus.fail) {
          return Center(child: Text('Bir hata oluştu'));
        } else {
          return ListView.builder(
            itemCount: state.profilePhotoList!.length,
            itemBuilder: (context, index) {
              return ProfilePhotoWidget(
                profilePhoto: state.profilePhotoList![index],
                removeFunc: () {
                  context.read<ProfilePhotoBloc>().add(
                    RemoveProfilePhotoEvent(
                      userId: state.profilePhotoList![index].user.id,
                      cdnKey: state.profilePhotoList![index].cdnKey,
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
