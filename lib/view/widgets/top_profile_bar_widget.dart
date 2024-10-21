import 'package:flutter/material.dart';

import '../../config/color.dart';
import '../../utils/constants.dart';

class TopProfileBarWidget extends StatelessWidget {
  const TopProfileBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: secondaryColor,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          CircleAvatar(
            radius: 20,
            child: Icon(Icons.person),
          )
        ],
      ),
    );;
  }
}
