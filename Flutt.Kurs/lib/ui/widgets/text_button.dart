import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget{
  const CustomTextButton({Key? key, required this.text,required this.func}) : super(key: key);
  final String text;
  final Function func;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){func();},
      style: ButtonStyle(
        side: MaterialStateProperty.all(const BorderSide(width: 1,color: Colors.cyanAccent)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
            
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 14),
        child: Text(text,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

}