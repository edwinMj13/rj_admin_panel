
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:project_rj_admin_panel/data/models/banner_model.dart';
import 'package:project_rj_admin_panel/data/models/storage_image_model.dart';
import 'package:project_rj_admin_panel/repository/common.dart';
import 'package:project_rj_admin_panel/view/providers/pick_image_provider.dart';
import 'package:provider/provider.dart';

class BannerProvider extends ChangeNotifier {
  BannerModel? _model;

  BannerModel? get bannerModel => _model;

  addBannerDetails(BuildContext context,List<StorageImageModel> imageList) async {
    final imageListBanner = BannerModel(bannerImages: imageList,nodeId:"");
    saveBannerImages(imageListBanner);
  }

  getBannerProvider(BuildContext context) async {
    _model = await getBannerImages();
    print("_Model $_model");
    context.read<PickImageProvider>().addToImages(_model!.bannerImages);
    notifyListeners();
  }
}
