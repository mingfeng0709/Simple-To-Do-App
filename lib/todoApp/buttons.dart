import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  final String btName;
  VoidCallback onPressed;

  MyButton({
    super.key, 
    required this.btName, 
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.white,
      child:Text(btName) ,
    );
  }
}