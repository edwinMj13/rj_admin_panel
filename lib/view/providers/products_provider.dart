import 'package:flutter/cupertino.dart';
import 'package:project_rj_admin_panel/data/models/product_model.dart';
import 'package:project_rj_admin_panel/repository/database_services_products.dart';

class ProductsProvider extends ChangeNotifier {
  List<ProductModel>? _productsList;
  List<ProductModel>? get productsList => _productsList;

  List<ProductModel>? _filteredProductsList;
  List<ProductModel>? get filteredProductsList => _filteredProductsList;

  final database = DatabaseServicesProducts();


  Future<void> addProductData(ProductModel model, VoidCallback callback) async {
    await database.uploadProductData(model).then((_)=> callback());
  }
  Future<void> updateProductData(ProductModel model,String firebaseNodeId, VoidCallback callback) async {
   await database.updateProductData(firebaseNodeId,model).then((_)=>callback());
  }

  getProductsDataProvider() async {
    _productsList= await database.getProductsData();
    notifyListeners();
  }
  deleteProductDataProvider(String nodeId) async {
    await database.deleteProduct(nodeId).then((_)=>getProductsDataProvider());
    getProductsDataProvider();
  }


}
