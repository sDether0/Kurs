import 'package:flutter/material.dart';
import 'package:kurs/data/models/folder.dart';
import 'package:kurs/ui/styles/app_text_styles.dart';

class FolderCard extends StatelessWidget {
  FolderCard({
    required this.mFolder, this.name
  });

  final MFolder mFolder;
  String? name;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Padding(
        padding:
        const EdgeInsets.fromLTRB(2, 3, 2, 0),
        child: Column(
          children: [
            mFolder.icon,
            Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    name??mFolder.name,
                    style:
                    AppTextStyles.h4.opacity(0.8),
                    //textAlign: TextAlign.center,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}