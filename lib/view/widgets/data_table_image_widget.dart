import 'package:flutter/material.dart';

class DataTableIMAGEWidget extends StatelessWidget {
  const DataTableIMAGEWidget({
    super.key,
    required this.image,
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(100),
          ),
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
        )
      /*FadeInImage(
     image: NetworkImage(
       image,
     ),
     placeholder: AssetImage("assets/placehoderimage.png"),
     imageErrorBuilder: (context, _, e) {
       return Image.asset("assets/placehoderimage.png");
     },
       ),*/
    );
  }
}
