import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/storage_image_model.dart';
import 'package:project_rj_admin_panel/view/providers/banner_provider.dart';
import 'package:project_rj_admin_panel/view/providers/pick_image_provider.dart';
import 'package:provider/provider.dart';

import '../../../../config/color.dart';
import '../../../../utils/text_controllers.dart';

class AddBannerImageWidget extends StatefulWidget {
  const AddBannerImageWidget({
    super.key,
  });

  @override
  State<AddBannerImageWidget> createState() => _AddBannerImageWidgetState();
}

class _AddBannerImageWidgetState extends State<AddBannerImageWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PickImageProvider>(
      builder: (context, value, _) {
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
                children: [const SizedBox(), _getButton(context, value.imagesUrlBanner)],
              ),
              value.imagesUrlBanner.isNotEmpty
                  ? SizedBox(
                      height: 210,
                      width: 300,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5),
                        itemBuilder: (context, index) {
                          print("Selected Images ${value.imagesUrlBanner.length}");

                          return Container(
                            // width: 75,
                            // height: 75,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    Container(
                                        margin: const EdgeInsets.only(top: 2.0, right: 2.0),
                                        width: 13,
                                        height: 13,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(50.0)),
                                        child: InkWell(
                                          onTap: () {
                                            context
                                                .read<PickImageProvider>()
                                                .deleteImageFromMultipleBanner(index);
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            size: 7,
                                            color: Colors.white,
                                          ),
                                        )),
                                  ],
                                ),

                                ClipRRect(
                                  child: Image.network(
                                    value.imagesUrlBanner[index].downloadUrl,
                                    fit: BoxFit.cover,
                                    width: 70,
                                    height: 70,
                                  ),
                                ),

                              ],
                            ),
                          );
                        },
                        itemCount: value.imagesUrlBanner.length,
                      ),
                    )
                  : SizedBox(),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<BannerProvider>()
                        .addBannerDetails(context, value.imagesUrlBanner);
                  },
                  child: const Text("Add Banner"))
            ],
          ),
        );
      },
    );
  }

  Widget _getButton(
    BuildContext context,
    List<StorageImageModel> value,
  ) {
    return value.isNotEmpty && value.length < 6
        ? IconButton(
            onPressed: () {
              context
                  .read<PickImageProvider>()
                  .pickMultipleImagesForBanner( () => callBack(), context, "banner_u");
            },
            icon: const Icon(Icons.update),
          )
        : _getNullOrOver(context, value);
  }

  callBack() {}

  Widget _getNullOrOver(BuildContext context, List<StorageImageModel> value) {
    return value.isEmpty
        ? IconButton(
            onPressed: () {
              context
                  .read<PickImageProvider>()
                  .pickMultipleImagesForBanner(() => callBack(), context, "banner_a");
            },
            icon: const Icon(Icons.add),
          )
        : SizedBox();
  }
}
