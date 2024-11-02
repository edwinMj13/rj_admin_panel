
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:project_rj_admin_panel/data/models/banner_model.dart';
import 'package:project_rj_admin_panel/data/models/storage_image_model.dart';
import 'package:project_rj_admin_panel/repository/common.dart';
import 'package:project_rj_admin_panel/view/providers/pick_image_provider.dart';
import 'package:provider/provider.dart';

class BannerProvider extends ChangeNotifier {
  List<StorageImageModel> _imageList = [];
  List<StorageImageModel> get imageList => _imageList;


  addBannerDetails(BuildContext context,List<StorageImageModel> imageList) async {
    final imageListBanner = BannerModel(bannerImages: imageList,nodeId:"");
    saveBannerImages(imageListBanner);
    context.read<PickImageProvider>().bannerImagesSetToNull();
  }

  getBannerProvider(BuildContext context) async {
    _imageList = await getBannerImages();
    context.read<PickImageProvider>().getBannerImagesToShow(_imageList);
    print("_Model $_imageList");
    /*print("_Model $_imageList");
    context.read<PickImageProvider>().addToImages(_imageList);*/
  }
}
