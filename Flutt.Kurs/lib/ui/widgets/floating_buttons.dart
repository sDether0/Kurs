import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
class FloatingMenu extends StatefulWidget
{
  const FloatingMenu():super();

  Widget _getFAB() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(size: 22),
      backgroundColor: const Color(0xFF801E48),
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // FAB 1
        SpeedDialChild(
            child: const Icon(Icons.assignment_turned_in),
            backgroundColor: const Color(0xFF801E48),
            onTap: () { /* do anything */ },
            label: 'Button 1',
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: const Color(0xFF801E48)),
        // FAB 2
        SpeedDialChild(
            child: const Icon(Icons.assignment_turned_in),
            backgroundColor: const Color(0xFF801E48),
            onTap: () {},
            label: 'Button 2',
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: const Color(0xFF801E48))
      ],
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}


