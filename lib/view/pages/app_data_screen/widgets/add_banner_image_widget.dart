import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/view/providers/banner_provider.dart';
import 'package:project_rj_admin_panel/view/providers/pick_image_provider.dart';
import 'package:provider/provider.dart';

import '../../../../config/color.dart';
import '../../../../utils/text_controllers.dart';

class AddBannerImageWidget extends StatefulWidget {
  const AddBannerImageWidget({super.key});

  @override
  State<AddBannerImageWidget> createState() => _AddBannerImageWidgetState();
}

class _AddBannerImageWidgetState extends State<AddBannerImageWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<BannerProvider>().getBannerProvider(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PickImageProvider>(builder: (context, value, _) {
      print("AddBannerImageWidget ${value.imagesUrl}");

      return Container(
        height: 400,
        width: 350,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Add Home Screen Banner",
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                value.imagesUrl.isNotEmpty && value.imagesUrl.length>=6
                ?SizedBox()
                    :IconButton(onPressed: () {
                      context.read<PickImageProvider>().pickMultipleImages("Banner",()=>callBack(),context);
                }, icon: Icon(Icons.add),)
              ],
            ),
            value.imagesUrl.isNotEmpty ?SizedBox(
              height: 210,
              width: 300,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5
                ),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                          value.imagesUrl[index].downloadUrl,
                          // width: 100,
                          // height: 10,
                        ),
                      ),
                  IconButton(
                  onPressed: ()=>context
                      .read<PickImageProvider>()
                      .deleteImageFromMultiple(index),
                  icon:const Icon(Icons.close),
                  iconSize: 7,
                  color: Colors.white,
                  ),

                    ],
                  );
                },
                itemCount: value.imagesUrl.length,
              ),
            ):SizedBox(),
            ElevatedButton(onPressed: () {
              context.read<BannerProvider>().addBannerDetails(context, value.imagesUrl);
            }, child: const Text("Add Banner"))
          ],
        ),
      );
    });
  }

  callBack() {}
}
