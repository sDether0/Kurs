import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kurs/data/models/file.dart';
import 'package:kurs/data/models/folder.dart';
import 'package:kurs/resources/app_colors.dart';
import 'package:kurs/ui/controllers.dart';
import 'package:kurs/ui/styles/app_text_styles.dart';
import 'package:kurs/ui/widgets/custom_context_buttons.dart';

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class ExtIcons {
  static Icon GetIcon(String extention) {
    switch (extention) {
      case ".exe":
        return const Icon(
          Icons.extension_outlined,
          color: AppColors.primaryColor,
          size: 40,
        );
      case ".rar":
        return const Icon(
          Icons.archive_outlined,
          color: AppColors.primaryColor,
          size: 40,
        );
      case ".jpg":
      case ".heic":
        return const Icon(
          Icons.image_outlined,
          color: AppColors.primaryColor,
          size: 40,
        );
      case ".txt":
        return const Icon(
          Icons.text_snippet_outlined,
          color: AppColors.primaryColor,
          size: 40,
        );
      case "f0lDeR":
        return const Icon(
          Icons.folder,
          color: AppColors.primaryColor,
          size: 60,
        );
      default:
        return const Icon(
          Icons.file_present_outlined,
          color: AppColors.primaryColor,
          size: 40,
        );
    }
  }
}

class Menus {
  static Future<dynamic> ioElementShowMenu(
      BuildContext context,
      LongPressStartDetails details,
      IOElement io,
      Function download,
      Function rename,
      Function delete,
      Function deleteLocal,
      Size size) {
    return showMenu(
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
              download(io);
              Navigator.pop(context);
            }),
          ),
          PopupMenuItem(
            child: RenameButton(func: () {
              // _cubit.renameFile(
              //     _cubit.mFolder.files[index]);
              showRenameDialog(context, size, io, rename);

              Navigator.pop(context);
            }),
          ),
          PopupMenuItem(
            child: DeleteButton(
              func: () {
                delete(io);
              },
              local: false,
            ),
          ),
          (io is MFile && io.downloaded
              ? PopupMenuItem(
                  child: DeleteButton(
                    func: () {
                      deleteLocal(io);
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
  }

  static Future<dynamic> showRenameDialog(
      BuildContext context, Size size, IOElement io, Function func) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: AppColors.primaryBackgroundColor,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.borderColor, width: 2),
                borderRadius: BorderRadius.circular(5)),
            child: SizedBox(
              height: size.height * 0.195,
              width: size.width * 0.2,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Rename file/folder",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Arvo',
                          color: AppColors.primaryTextColor),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextField(
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.blue.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                )),
                            cursorColor: AppColors.primaryTextColor,
                            style: const TextStyle(fontFamily: 'Arvo'),
                            controller: Controllers.fileRenameController =
                                TextEditingController(
                                    text: io is MFile
                                        ? io.shortName
                                        : (io as MFolder).name),
                          ),
                        ),
                        io is MFile
                            ? Flexible(
                                child: SizedBox(
                                  width: 60,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.blue.shade100,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide.none,
                                        )),
                                    cursorColor: AppColors.primaryTextColor,
                                    style: const TextStyle(fontFamily: 'Arvo'),
                                    controller:
                                        Controllers.fileExtensionController =
                                            TextEditingController(text: io.ext),
                                  ),
                                ),
                              )
                            : SizedBox.shrink()
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      //crossAxisAlignment : CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            func(io);
                            Controllers.fileRenameController =
                                TextEditingController(text: "");
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "OK",
                            style: AppTextStyles.h3,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Controllers.fileRenameController =
                                  TextEditingController(text: "");
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
            ),
          );
        });
  }
}
