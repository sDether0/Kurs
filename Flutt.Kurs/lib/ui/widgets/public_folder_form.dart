import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs/cubit/navigation/navigation_cubit.dart';
import 'package:kurs/cubit/public_folder/public_folder_cubit.dart';
import 'package:kurs/data/models/file.dart';
import 'package:kurs/data/models/public_folder.dart';
import 'package:kurs/resources/app_colors.dart';
import 'package:kurs/ui/widgets/file_card.dart';
import 'package:kurs/ui/widgets/folder_card.dart';
import 'package:kurs/ui/widgets/logout.dart';
import 'package:kurs/utils.dart';

class PublicFolderForm extends StatelessWidget {
  const PublicFolderForm({required this.loading}) : super();

  final bool loading;

  @override
  Widget build(BuildContext context) {
    var _cubit = context.read<PublicFolderCubit>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: AppColors.primaryColor,
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
            if (details.primaryVelocity! > 0) {
              if (_cubit.mFolder != null) {
                if (_cubit.mFolder!.parent! is MPublicFolder) {
                  _cubit.changeFolder(null);
                } else {
                  _cubit.changeFolder(_cubit.mFolder!.parent!);
                }
              }
            }
            if (details.primaryVelocity! < 0) {
              context.read<NavigationCubit>().pushToMainFolderScene();
            }
          },
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : GridView.count(
                    crossAxisCount: 4,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                    primary: true,
                    padding: const EdgeInsets.all(10),
                    children: _cubit.mFolder != null
                        ? List.generate(_cubit.mFolder!.folders.length,
                                (index) {
                              return GestureDetector(
                                  onTap: () {
                                    _cubit.changeFolder(
                                        _cubit.mFolder!.folders[index]);
                                  },
                                  child: FolderCard(
                                      mFolder: _cubit.mFolder!.folders[index]),
                                  onLongPressStart: (details) {
                                    Menus.ioElementShowMenu(
                                        context,
                                        details,
                                        _cubit.mFolder!.folders[index],
                                        (IOElement io) {},
                                        _cubit.renameIO,
                                        _cubit.deleteIO,
                                        (IOElement io) {},
                                        size);
                                  });
                            }) +
                            List.generate(_cubit.mFolder!.files.length,
                                (index) {
                              return GestureDetector(
                                onTap: () {
                                  if (_cubit.mFolder!.files[index].downloaded &&
                                      _cubit.mFolder!.files[index].ext ==
                                          ".jpg") {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          print(index);
                                          print(_cubit
                                              .mFolder!.files[index].localPath);
                                          return AlertDialog(
                                            contentPadding: EdgeInsets.all(0),
                                            backgroundColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    color:
                                                        AppColors.borderColor,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            content: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.file(File(_cubit
                                                  .mFolder!
                                                  .files[index]
                                                  .localPath!)),
                                            ),
                                          );
                                        });
                                  }
                                },
                                onLongPressStart: (details) {
                                  Menus.ioElementShowMenu(
                                      context,
                                      details,
                                      _cubit.mFolder!.files[index],
                                      _cubit.saveFile,
                                      _cubit.renameIO,
                                      _cubit.deleteIO,
                                      (IOElement io) {},
                                      size);
                                },
                                child: FileCard(
                                    mFile: _cubit.mFolder!.files[index]),
                              );
                            })
                        : List.generate(_cubit.mPFolders.length, (index) {
                            return GestureDetector(
                                onTap: () {
                                  _cubit.changeFolder(_cubit.mPFolders[index]);
                                },
                                child: FolderCard(
                                    mFolder: _cubit.mPFolders[index].mFolder, name: _cubit.mPFolders[index].name,));
                          }),
                  ),
          )),
        ),
      ),
    );
  }
}
