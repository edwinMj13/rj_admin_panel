import 'package:flutter/cupertino.dart';
import 'package:project_rj_admin_panel/data/models/brand_model.dart';
import 'package:project_rj_admin_panel/repository/database_services_brand.dart';

class BrandProvider extends ChangeNotifier {

  bool _isLoading=false;

  List<BrandModel>? _brandM;

  List<BrandModel>? get brandModel => _brandM;
  bool get isLoading =>_isLoading;

  final dbSevices = DatabaseServicesBrand();

  notifyWidgetListener() {
    notifyListeners();
  }

  getBrandsProvider() async {
    _brandM = await dbSevices.getBrands();
    notifyListeners();
  }

  Future<void> uploadBrandDetails(BrandModel model) async {
    await dbSevices.addBrandDetails(model);
  }

  editBrandDetails(
      BrandModel model, String nodeId, VoidCallback callback) async {
    await dbSevices.editBrandDetails(model, nodeId).then((_) => callback());
  }

  deleteBrandDetails(String nodeId) async {
    await dbSevices.deleteBrandDetails(nodeId).then((_) {
      print("Brands DELeted ");
      getBrandsProvider();
    });
  }


}
