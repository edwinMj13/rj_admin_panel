import 'package:flutter/material.dart';

class ListItemsTitleWidget extends StatelessWidget {
  final String sectionTitle;
  const ListItemsTitleWidget({super.key,required this.sectionTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Text(sectionTitle),
    );
  }
}
