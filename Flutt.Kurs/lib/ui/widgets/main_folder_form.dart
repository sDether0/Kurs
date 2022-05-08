import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs/cubit/main_folder/cubit.dart';
import 'package:kurs/cubit/navigation/cubit.dart';
import 'package:kurs/resources/app_colors.dart';
import 'package:kurs/ui/controllers.dart';
import 'package:kurs/ui/styles/app_text_styles.dart';
import 'package:kurs/ui/widgets/custom_context_buttons.dart';
import 'package:kurs/ui/widgets/floating_buttons.dart';

import 'package:kurs/ui/widgets/logout.dart';

import 'download.dart';

class MainFolderForm extends StatelessWidget {
  const MainFolderForm({required this.loading}) : super();

  final bool loading;

  @override
  Widget build(BuildContext context) {
    var _cubit = context.read<MainFolderCubit>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              children: [
                const Text(
                  "Local files",
                  style: TextStyle(fontSize: 20, fontFamily: 'Arvo'),
                ),
                loading
                    ? const SizedBox.shrink()
                    : Text(
                        _cubit.mFolder == _cubit.rootFolder
                            ? "root"
                            : _cubit.mFolder.name,
                        style:
                            const TextStyle(fontSize: 15, fontFamily: 'Arvo'),
                      ),
              ],
            ),
          ),
          leadingWidth: 80,
          leading: Padding(
            padding: const EdgeInsets.only(
              top: 5,
            ),
            // child: Row(
            //   children: [
            //     // IconButton(
            //     //     icon: const Icon(
            //     //       Icons.logout,
            //     //       size: 35,
            //     //     ),
            //     //     onPressed: () {}),
            //     IconButton(
            //         icon: const Icon(
            //           Icons.upload_sharp,
            //           size: 35,
            //         ),
            //         onPressed: () {}),
            //   ],
            // ),
            child: DownloadToServerButton(
              func: () {
                _cubit.uploadFile();
              },
            ),
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
              if (_cubit.mFolder.parent != null) {
                _cubit.changeFolder(_cubit.mFolder.parent!);
              }
            }
            if (details.primaryVelocity! < 0) {
              context.read<NavigationCubit>().pushToPublicFolderScene();
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
                    children:
                        List.generate(_cubit.mFolder.folders.length, (index) {
                              return GestureDetector(
                                  onTap: () {
                                    print(index);
                                    _cubit.changeFolder(
                                        _cubit.mFolder.folders[index]);
                                  },
                                  child: Card(
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 3, 2, 0),
                                      child: Column(
                                        children: [
                                          _cubit.mFolder.folders[index].icon,
                                          Expanded(
                                              child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Text(
                                              _cubit
                                                  .mFolder.folders[index].name,
                                              style:
                                                  AppTextStyles.h4.opacity(0.8),
                                              //textAlign: TextAlign.center,
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                  ));
                            }) +
                            List.generate(_cubit.mFolder.files.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  if (_cubit.mFolder.files[index].downloaded &&
                                      _cubit.mFolder.files[index].ext ==
                                          ".jpg") {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          print(index);
                                          print(_cubit
                                              .mFolder.files[index].localPath);
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
                                                  .mFolder
                                                  .files[index]
                                                  .localPath!)),
                                            ),
                                          );
                                        });
                                  }
                                },
                                onLongPressStart: (details) {
                                  showMenu(
                                      context: context,
                                      position: RelativeRect.fromLTRB(
                                          details.globalPosition.dx,
                                          details.globalPosition.dy,
                                          details.globalPosition.dx,
                                          details.globalPosition.dy),
                                      color: AppColors.primaryBackgroundColor,
                                      items: [
                                        PopupMenuItem(
                                          child: DownloadButton(func: () {
                                            _cubit.downloadFile(
                                                _cubit.mFolder.files[index]);
                                            Navigator.pop(context);
                                          }),
                                        ),
                                        PopupMenuItem(
                                          child: RenameButton(func: () {
                                            // _cubit.renameFile(
                                            //     _cubit.mFolder.files[index]);
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    backgroundColor: AppColors
                                                        .primaryBackgroundColor,
                                                    shape: RoundedRectangleBorder(
                                                        side: const BorderSide(
                                                            color: AppColors
                                                                .borderColor,
                                                            width: 2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: SizedBox(
                                                      height:
                                                          size.height * 0.195,
                                                      width: size.width * 0.2,
                                                      child: Column(
                                                        children: [
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 15),
                                                            child: Text(
                                                              "Rename file/folder",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      'Arvo',
                                                                  color: AppColors
                                                                      .primaryTextColor),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10,
                                                                    right: 10,
                                                                    top: 10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Expanded(
                                                                  flex: 3,
                                                                  child:
                                                                      TextField(
                                                                    decoration: InputDecoration(
                                                                        filled: true,
                                                                        fillColor: Colors.blue.shade100,
                                                                        border: OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                          borderSide:
                                                                              BorderSide.none,
                                                                        )),
                                                                    cursorColor:
                                                                        AppColors
                                                                            .primaryTextColor,
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            'Arvo'),
                                                                    controller: Controllers.fileRenameController = TextEditingController(
                                                                        text: _cubit
                                                                            .mFolder
                                                                            .files[index]
                                                                            .shortName),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 60,
                                                                    child:
                                                                        TextField(
                                                                      decoration: InputDecoration(
                                                                          filled: true,
                                                                          fillColor: Colors.blue.shade100,
                                                                          border: OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                            borderSide:
                                                                                BorderSide.none,
                                                                          )),
                                                                      cursorColor:
                                                                          AppColors
                                                                              .primaryTextColor,
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                              'Arvo'),
                                                                      controller: Controllers.fileExtensionController = TextEditingController(
                                                                          text: _cubit
                                                                              .mFolder
                                                                              .files[index]
                                                                              .ext),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 10),
                                                            child: Row(
                                                              //crossAxisAlignment : CrossAxisAlignment.center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    _cubit.renameFile(_cubit
                                                                        .mFolder
                                                                        .files[index]);
                                                                    Controllers
                                                                            .fileRenameController =
                                                                        TextEditingController(
                                                                            text:
                                                                                "");
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    "OK",
                                                                    style:
                                                                        AppTextStyles
                                                                            .h3,
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Controllers
                                                                              .fileRenameController =
                                                                          TextEditingController(
                                                                              text: "");
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      "Cancel",
                                                                      style:
                                                                          AppTextStyles
                                                                              .h3,
                                                                    ),
                                                                    style:
                                                                        const ButtonStyle())
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });

                                            Navigator.pop(context);
                                          }),
                                        ),
                                        PopupMenuItem(
                                          child: DeleteButton(
                                            func: () {},
                                            local: false,
                                          ),
                                        ),
                                        (_cubit.mFolder.files[index].downloaded
                                            ? PopupMenuItem(
                                                child: DeleteButton(
                                                  func: () {
                                                    _cubit.deleteFile(_cubit
                                                        .mFolder.files[index]);
                                                    Navigator.pop(context);
                                                  },
                                                  local: true,
                                                ),
                                              )
                                            : const PopupMenuItem(
                                                child: SizedBox.shrink(),
                                                height: 0,
                                              ))
                                      ]);
                                },
                                child: Card(
                                    color: AppColors.itemPlateColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(9),
                                        side: BorderSide(
                                            color: _cubit.mFolder.files[index]
                                                    .downloaded
                                                ? AppColors.borderColorDown
                                                : AppColors.borderColor,
                                            width: 1)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 7, horizontal: 3),
                                      child: Column(children: [
                                        _cubit.mFolder.files[index].icon,
                                        Expanded(
                                            child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            _cubit.mFolder.files[index].name,
                                            style:
                                                AppTextStyles.h4.opacity(0.8),
                                          ),
                                        ))
                                      ]),
                                    )),
                              );
                            }),
                  ),
          )),
        ),
      ),
    );
  }
}
