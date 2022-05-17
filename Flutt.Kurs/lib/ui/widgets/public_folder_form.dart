import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kurs/cubit/navigation/navigation_cubit.dart';
import 'package:kurs/cubit/public_folder/public_folder_cubit.dart';
import 'package:kurs/data/models/file.dart';
import 'package:kurs/data/models/public_folder.dart';
import 'package:kurs/resources/app_colors.dart';
import 'package:kurs/ui/controllers.dart';
import 'package:kurs/ui/widgets/file_card.dart';
import 'package:kurs/ui/widgets/floating_buttons.dart';
import 'package:kurs/ui/widgets/folder_card.dart';
import 'package:kurs/ui/widgets/logout.dart';
import 'package:kurs/utils.dart';
import 'package:kurs/ui/styles/app_text_styles.dart';

class PublicFolderForm extends StatelessWidget {
  const PublicFolderForm({required this.loading}) : super();

  final bool loading;

  @override
  Widget build(BuildContext context) {
    var _cubit = context.read<PublicFolderCubit>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: _cubit.mFolder == null
          ? SpeedDial(
              animatedIcon: AnimatedIcons.menu_close,
              overlayOpacity: 0,
              animatedIconTheme: const IconThemeData(size: 22),
              backgroundColor: AppColors.primaryColor,
              visible: true,
              curve: Curves.bounceIn,
              children: [
                  SpeedDialChild(
                    child: const Icon(Icons.create_new_folder),
                    backgroundColor: AppColors.primaryColor,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                backgroundColor:
                                    AppColors.primaryBackgroundColor,
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: AppColors.borderColor, width: 2),
                                    borderRadius: BorderRadius.circular(5)),
                                child: SizedBox(
                                  height: size.height * 0.195,
                                  width: size.width * 0.2,
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Text(
                                          "Create folder",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Arvo',
                                              color:
                                                  AppColors.primaryTextColor),
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10, right: 10),
                                          child: TextField(
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.blue.shade100,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide.none,
                                                )),
                                            cursorColor:
                                                AppColors.primaryTextColor,
                                            style: const TextStyle(
                                                fontFamily: 'Arvo'),
                                            controller: Controllers
                                                    .publicFolderNameController =
                                                TextEditingController(),
                                          )),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Row(
                                          //crossAxisAlignment : CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                _cubit.createPublicFolder(
                                                    Controllers
                                                        .publicFolderNameController
                                                        .text);
                                                Controllers
                                                        .publicFolderNameController =
                                                    TextEditingController(
                                                        text: "");
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                "OK",
                                                style: AppTextStyles.h3,
                                              ),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  Controllers
                                                          .publicFolderNameController =
                                                      TextEditingController(
                                                          text: "");
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "Cancel",
                                                  style: AppTextStyles.h3,
                                                ),
                                                style: const ButtonStyle())
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          });
                    },
                  ),
                ])
          : FloatingMenu(func: () {
              _cubit.uploadFile();
            }, func1: () { showDialog(context: context,
          builder: (context) {
            return Dialog(
                backgroundColor:
                AppColors.primaryBackgroundColor,
                shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color: AppColors.borderColor, width: 2),
                    borderRadius: BorderRadius.circular(5)),
                child: SizedBox(
                  height: size.height * 0.195,
                  width: size.width * 0.2,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          "Create folder",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Arvo',
                              color:
                              AppColors.primaryTextColor),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 10, right: 10),
                          child: TextField(
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.blue.shade100,
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                )),
                            cursorColor:
                            AppColors.primaryTextColor,
                            style: const TextStyle(
                                fontFamily: 'Arvo'),
                            controller: Controllers
                                .publicFolderNameController =
                                TextEditingController(),
                          )),
                      Padding(
                        padding:
                        const EdgeInsets.only(right: 10),
                        child: Row(
                          //crossAxisAlignment : CrossAxisAlignment.center,
                          mainAxisAlignment:
                          MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                _cubit.createFolder();
                                Controllers
                                    .publicFolderNameController =
                                    TextEditingController(
                                        text: "");
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "OK",
                                style: AppTextStyles.h3,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Controllers
                                      .publicFolderNameController =
                                      TextEditingController(
                                          text: "");
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Cancel",
                                  style: AppTextStyles.h3,
                                ),
                                style: const ButtonStyle())
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
          }); }),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          leadingWidth: size.width * 0.35,
          leading: const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Public folders:",
                  style: TextStyle(fontSize: 19, fontFamily: 'Arvo')),
            ),
          ),
          title: loading
              ? const SizedBox()
              : Text(
                  _cubit.mFolder == null
                      ? "root"
                      : _cubit.mFolder!.fullPath.split("\\").length <= 1
                          ? (_cubit.mFolder!.parent as MPublicFolder).name
                          : _cubit.mFolder!.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, fontFamily: 'Arvo'),
                ),
          actions: const [LogoutButton()],
        ),
      ),
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(60),
      //   child: AppBar(
      //     backgroundColor: AppColors.primaryColor,
      //     centerTitle: true,
      //     title: Padding(
      //       padding: const EdgeInsets.only(top: 5),
      //       child: Column(
      //         children: const [
      //           Text(
      //             "Public folders",
      //             style: TextStyle(fontSize: 20, fontFamily: 'Arvo'),
      //           ),
      //           Text(
      //             "Public folders",
      //             style: TextStyle(fontSize: 15, fontFamily: 'Arvo'),
      //           ),
      //         ],
      //       ),
      //     ),
      //     leadingWidth: 80,
      //     leading: Padding(
      //       padding: const EdgeInsets.only(
      //         top: 5,
      //       ),
      //       child: IconButton(
      //           icon: const Icon(
      //             Icons.upload_sharp,
      //             size: 35,
      //           ),
      //           onPressed: () {}),
      //     ),
      //     actions: const [
      //       Padding(
      //         padding: EdgeInsets.only(top: 5, right: 15),
      //         child: LogoutButton(),
      //       )
      //     ],
      //   ),
      // ),
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
                                  mFolder: _cubit.mPFolders[index].mFolder,
                                  name: _cubit.mPFolders[index].name,
                                ));
                          }),
                  ),
          )),
        ),
      ),
    );
  }
}
