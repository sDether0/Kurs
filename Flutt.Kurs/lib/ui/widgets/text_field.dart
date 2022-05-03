import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.textController,
      required this.obscure,
      required this.hint})
      : super(key: key);

  final TextEditingController textController;
  final bool obscure;
  final String hint;

  @override
  Widget build(BuildContext context) {
    bool showPass = obscure;
    return StatefulBuilder(builder: (context, setState) {
      return TextField(
        decoration: InputDecoration(
          label: Text(
            hint,
            style: const TextStyle(color: Colors.white60, fontFamily: "Arvo" ),
          ),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
              borderRadius: BorderRadius.circular(15)),
          suffixIcon: obscure
              ? GestureDetector(
                  onTapDown: (s) {
                    setState(() {
                      showPass = false;
                    });
                  },
                  onTapUp: (s) {
                    setState(() {
                      showPass = true;
                    });
                  },
                  onLongPressDown: (s) {
                    setState(() {
                      showPass = false;
                    });
                  },
                  onLongPressUp: () {
                    setState(() {
                      showPass = true;
                    });
                  },
                  child:
                      const Icon(Icons.remove_red_eye, color: Colors.blueGrey))
              : SizedBox(),
        ),
        controller: textController,
        obscureText: showPass,
        style: const TextStyle(color: Colors.white),
      );
    });
  }
}
