import 'package:flutter/material.dart';

class Elev_Custom_IconButton extends StatelessWidget {
  final IconData icon;
  final iconColor;
  final buttonText;
  final backgroundColor;
  final textColor;
  final VoidCallback callback;

  const Elev_Custom_IconButton(
      {super.key,this.iconColor,required this.callback, required this.icon, this.buttonText,this.backgroundColor,this.textColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: ()=>callback(),
      icon: Icon(icon,color: iconColor,),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(),
      ),
      label: Text(buttonText,style: TextStyle(color: textColor),),
    );
    // return const Row(
    //   children: [
    //     Icon(
    //       Icons.add,
    //       color: Colors.white,
    //     ),
    //     SizedBox(
    //       width: 10,
    //     ),
    //     Text(
    //       "Add",
    //       style: TextStyle(fontSize: 16, color: Colors.white),
    //     ),
    //   ],
    // );
  }
}
