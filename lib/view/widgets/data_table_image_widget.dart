import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/view/widgets/place_holder_image_widget.dart';

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
            color: Colors.white12,
            borderRadius: BorderRadius.circular(100),
          ),
          child: PlaceHolderImageWidget(image: image,),
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


