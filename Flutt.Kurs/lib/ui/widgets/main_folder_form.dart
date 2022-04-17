import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs/cubit/main_folder/cubit.dart';

class MainFolderForm extends StatelessWidget {
  const MainFolderForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _cubit = context.read<MainFolderCubit>();
    return Card(
        shape: RoundedRectangleBorder(
            side: const BorderSide(width: 2, color: Colors.purple),
            borderRadius: BorderRadius.circular(15)),
        child: GridView.count(
          crossAxisCount: 4,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
          primary: true,
          padding: const EdgeInsets.all(12),
          children: List.generate(_cubit.icons.length, (index) {
            return SizedBox(
                width: 50,
                height: 50,
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(children: [
                    _cubit.icons[index],
                    Text(_cubit.paths[index])
                  ]),
                )
                )
            );
          }),
        )
    );
  }
}
