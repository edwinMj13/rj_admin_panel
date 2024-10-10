import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonServices {
  static Widget showPlaceHolderImageinDataTable(
      ImageChunkEvent? loadingProgress, Widget child) {
    if (loadingProgress == null) return child;
    return const Icon(
      CupertinoIcons.cube,
      size: 20,
      color: Colors.grey,
    );
  }
}
