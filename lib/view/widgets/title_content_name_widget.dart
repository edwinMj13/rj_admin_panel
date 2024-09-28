import 'package:flutter/material.dart';

class TitleContentNameWidget extends StatelessWidget {
  const TitleContentNameWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,top: 20),
      child: Text(title,style: const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
    );
  }
}