import 'package:flutter/material.dart';

class Elev_Button extends StatelessWidget {
  final buttonBackground;
  final borderColor;
  final textColor;
  final String text;
  final VoidCallback onPressed;
  const Elev_Button({
    super.key,
    this.borderColor,
    this.buttonBackground,
    this.textColor,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ()=>onPressed(),
      style: ElevatedButton.styleFrom(
          backgroundColor: buttonBackground,
          side: BorderSide(color: borderColor ?? buttonBackground)
      ),
      child: Text(text,style: TextStyle(color: textColor),),
    );
  }
}