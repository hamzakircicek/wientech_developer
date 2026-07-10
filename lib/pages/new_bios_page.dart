import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wien_tech_admin/bloc/bios_bloc/bloc.dart';
import 'package:wien_tech_admin/bloc/bios_bloc/event.dart';
import 'package:wien_tech_admin/bloc/bios_bloc/state.dart';
import 'package:wien_tech_admin/widgets/bio_widget.dart';

class NewBiosPage extends StatefulWidget {
  const NewBiosPage({super.key});

  @override
  State<NewBiosPage> createState() => _NewBiosPageState();
}

class _NewBiosPageState extends State<NewBiosPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBios();
  }

  void getBios() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BiosBloc>().add(GetBios());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BiosBloc, BiosState>(
      builder: (context, state) {
        if (state.pageStatus == BiosStatus.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.pageStatus == BiosStatus.fail) {
          return Center(child: Text('Bir hata oluştu'));
        } else {
          return ListView.builder(
            itemCount: state.bioList!.length,
            itemBuilder: (context, index) {
              return BioWidget(
                bio: state.bioList![index],
                removeFunc: () {
                  context.read<BiosBloc>().add(
                    RemoveBioEvent(userId: state.bioList![index].user.id),
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
