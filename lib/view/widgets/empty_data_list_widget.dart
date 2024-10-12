import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyDataListWidget extends StatelessWidget {
  const EmptyDataListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: 100,
          width: 100,
          child: SvgPicture.asset("empty_list/empty_image.svg")),
    );
  }
}
