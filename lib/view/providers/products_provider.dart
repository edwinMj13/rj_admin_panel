import 'package:flutter/cupertino.dart';
import 'package:project_rj_admin_panel/data/models/product_model.dart';
import 'package:project_rj_admin_panel/repository/database_services_products.dart';

class ProductsProvider extends ChangeNotifier {
  List<ProductModel>? _productsList;

  List<ProductModel>? get productsList => _productsList;

  final database = DatabaseServicesProducts();


  Future<void> addProductData(ProductModel model) async {
    database.uploadProductData(model);
  }
  Future<void> updateProductData(ProductModel model,String firebaseNodeId) async {
    database.updateProductData(firebaseNodeId,model);
  }

  getProductsDataProvider() async {
    _productsList= await database.getProductsData();
    notifyListeners();
  }
  deleteProductDataProvider(String nodeId) async {
    await database.deleteProduct(nodeId).then((_)=>getProductsDataProvider());
  }

}
