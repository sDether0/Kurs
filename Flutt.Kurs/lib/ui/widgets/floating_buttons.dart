import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kurs/resources/app_colors.dart';

class FloatingMenu extends StatelessWidget {
  const FloatingMenu({required this.func, required this.func1}) : super();
  final Function func;
  final Function func1;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      overlayOpacity: 0,
      animatedIconTheme: const IconThemeData(size: 22),
      backgroundColor: AppColors.primaryColor,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // FAB 1
        SpeedDialChild(
          child: const Icon(Icons.upload_file),
          backgroundColor: AppColors.primaryColor,
          onTap: () {
            func();
          },
        ),
        // FAB 2
        SpeedDialChild(
          child: const Icon(Icons.create_new_folder),
          backgroundColor: AppColors.primaryColor,
          onTap: () {
            func1();
          },
        )
      ],
    );
  }
}
