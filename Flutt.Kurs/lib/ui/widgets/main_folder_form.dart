import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs/cubit/main_folder/cubit.dart';
import 'package:kurs/resources/app_colors.dart';
import 'package:kurs/resources/app_strings.dart';
import 'package:kurs/ui/styles/app_text_styles.dart';
import 'package:kurs/ui/widgets/custom_context_buttons.dart';

class MainFolderForm extends StatelessWidget {
  const MainFolderForm({Key? key, required this.loading}) : super(key: key);

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
            title: const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                "S682 disk",
                style: TextStyle(fontSize: 30, fontFamily: 'Arvo'),
              ),
            ),
            leadingWidth: 120,
            leading: Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: Row(
                children: [
                  IconButton(
                      icon: const Icon(
                        Icons.account_box_rounded,
                        size: 35,
                      ),
                      onPressed: () {}),
                  IconButton(
                      icon: const Icon(
                        Icons.upload_sharp,
                        size: 35,
                      ),
                      onPressed: () {}),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: AppColors.primaryBackgroundColor,
        body: SafeArea(
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
                  children: List.generate(_cubit.icons.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        if (_cubit.localPaths.containsKey(index.toString())) {
                          if (_cubit.localPaths[index.toString()]!
                                  .split(".")
                                  .last ==
                              "jpg") {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      backgroundColor: Colors.black87,
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: AppColors.borderColor,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      content: Image.file(File(_cubit
                                          .localPaths[index.toString()]!)),
                                    ));
                          }
                        }
                        if (_cubit.icons[index].icon == Icons.folder) {}
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
                                  _cubit.downloadFile(index);
                                  Navigator.pop(context);
                                }),
                              ),
                              PopupMenuItem(
                                child: RenameButton(func: () {Navigator.pop(context);}),
                              ),
                              PopupMenuItem(
                                child: DeleteButton(func: () {},local: false,),
                              ),
                              (_cubit.localPaths.containsKey(index.toString())?PopupMenuItem(child: DeleteButton(func: () {_cubit.deleteFile(index);Navigator.pop(context);},local: true,),):const PopupMenuItem(child: SizedBox.shrink(),height: 0,))

                            ]);

                      },
                      child: _cubit.icons[index].icon == Icons.folder
                          ? Card(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(2, 3, 2, 0),
                                child: Column(
                                  children: [
                                    _cubit.icons[index],
                                    Expanded(
                                        child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        _cubit.paths[index],
                                        style: AppTextStyles.h4.opacity(0.8),
                                        //textAlign: TextAlign.center,
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            )
                          : Card(
                              color: AppColors.itemPlateColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9),
                                  side:  BorderSide(color: _cubit.localPaths.containsKey(index.toString())? AppColors.borderColorDown:AppColors.borderColor, width: 1)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 3),
                                child: Column(children: [
                                  _cubit.icons[index],
                                  Expanded(
                                      child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      _cubit.paths[index],
                                      style: AppTextStyles.h4.opacity(0.8),
                                    ),
                                  ))
                                ]),
                              )),
                    );
                  }),
                ),
        )));
  }
}
