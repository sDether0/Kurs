import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs/resources/app_colors.dart';
import 'package:kurs/ui/widgets/logout.dart';

import 'package:kurs/cubit/navigation/navigation_cubit.dart';
import 'package:kurs/cubit/public_folder/public_folder_cubit.dart';

class PublicFolderForm extends StatelessWidget {
  const PublicFolderForm({required this.loading}) : super();

  final bool loading;

  @override
  Widget build(BuildContext context) {
    var _cubit = context.read<PublicFolderCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              children: const [
                Text(
                  "Public folders",
                  style: TextStyle(fontSize: 20, fontFamily: 'Arvo'),
                ),
                Text(
                  "Public folders",
                  style: TextStyle(fontSize: 15, fontFamily: 'Arvo'),
                ),
              ],
            ),
          ),
          leadingWidth: 80,
          leading: Padding(
            padding: const EdgeInsets.only(
              top: 5,
            ),
            child: IconButton(
                icon: const Icon(
                  Icons.upload_sharp,
                  size: 35,
                ),
                onPressed: () {}),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(top: 5, right: 15),
              child: LogoutButton(),
            )
          ],
        ),
      ),
      backgroundColor: AppColors.primaryBackgroundColor,
      body: RefreshIndicator(
        onRefresh: _cubit.refresh,
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            // if (details.primaryVelocity! > 0) {
            // // if (_cubit.mFolder.parent != null) {
            // // _cubit.changeFolder(_cubit.mFolder.parent!);
            // }
            // }
            if (details.primaryVelocity! < 0) {
              context.read<NavigationCubit>().pushToMainFolderScene();
            }
          },
        ),
      ),
    );
  }
}
