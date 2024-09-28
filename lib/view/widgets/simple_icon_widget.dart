import 'package:flutter/material.dart';

class SimpleIconWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPress;
  final Color iconColor;
  const SimpleIconWidget({super.key, required this.icon, required this.onPress, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return  IconButton(
      onPressed: ()=>onPress(),
      icon: Icon(icon,color: iconColor,),
    );
  }
}
