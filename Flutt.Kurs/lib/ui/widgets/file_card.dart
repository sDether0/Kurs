import 'package:flutter/material.dart';
import 'package:kurs/data/models/file.dart';
import 'package:kurs/resources/app_colors.dart';
import 'package:kurs/ui/styles/app_text_styles.dart';

class FileCard extends StatelessWidget {
  const FileCard({
    required this.mFile,
  });

  final MFile mFile;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: AppColors.itemPlateColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
            side: BorderSide(
                color: mFile.downloaded
                    ? AppColors.borderColorDown
                    : AppColors.borderColor,
                width: mFile.downloaded ? 2:1)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 3),
          child: Column(children: [
            mFile.icon,
            Expanded(
                child: Align(
              alignment: Alignment.center,
              child: Text(
                mFile.name,
                style: mFile.downloaded ? AppTextStyles.h4.opacity(0.8).bold900(): AppTextStyles.h4.opacity(0.8),
              ),
            ))
          ]),
        ));
  }
}
