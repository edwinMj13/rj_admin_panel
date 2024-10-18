import 'package:flutter/material.dart';

class PlaceHolderImageWidget extends StatelessWidget {
  const PlaceHolderImageWidget({
    super.key,
    required this.image,
    this.size=40,
  });

  final String image;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size!,
      width: size!,
      child: FadeInImage(
        fadeInDuration: Duration(milliseconds: 500),
        image: NetworkImage(
          image,
        ),
        placeholder:const AssetImage("assets/image-circle-svgrepo-com.png"),
        /*imageErrorBuilder: (context, child, loadingProgress) {
          return CommonServices.showPlaceHolderImageinDataTable(loadingProgress, child);
        }*/
      ),
    );
  }
}