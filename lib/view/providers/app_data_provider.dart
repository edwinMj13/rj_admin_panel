import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/services/common_services.dart';
import 'package:project_rj_admin_panel/services/products_services/products_services.dart';
import 'package:project_rj_admin_panel/services/products_services/text_field_actions.dart';
import 'package:project_rj_admin_panel/utils/common_methods.dart';
import 'package:project_rj_admin_panel/utils/text_controllers.dart';

import '../../data/models/product_model.dart';
import '../../repository/database_services_products.dart';

class AppDataProvider extends ChangeNotifier {
  List<ProductModel>? _filteredProductsList;

  List<ProductModel>? get filteredProductsList => _filteredProductsList;
  final database = DatabaseServicesProducts();
  static ValueNotifier<List<ProductModel>> filteredList = ValueNotifier([]);

  ProductModel? _productModel;
  ProductModel? get productModel => _productModel ;

  CommonServices commonServices =CommonServices();

  getFilteredProducts(String label) async {
    final list = await database.getProductsData();
    filteredList.value =
        list.where((model) => model.itemName.toLowerCase().contains(label))
            .toList();
    notifyListeners();
  }

  selectedProduct(ProductModel model){
    _productModel = model;
  }

  updateProductDetailWithOffer(BuildContext context) async {
    commonServices.loadingDialogShow(context);
    final model = ProductModel(
      firebaseNodeId: productModel!.firebaseNodeId,
      imagesList: getImageListFromDynamic(productModel!.imagesList),
      itemName: productModel!.itemName,
      category: productModel!.category,
      itemBrand: productModel!.itemBrand,
      itemAddedDate: productModel!.itemAddedDate,
      itemMrp: productModel!.itemMrp,
      price: productModel!.price,
      subCategory: productModel!.subCategory,
      mainImage: productModel!.mainImage,
      sellingPrize: productModel!.sellingPrize,
      productId: productModel!.productId,
      stock: productModel!.stock,
      offerPercent: appDataProductOfferPercentController.text,
      offerAmount: appDataProductLastAmountController.text,
      status: productModel!.status,
      description: productModel!.description,);
    // print("SAVE offer Details ${model.runtimeType}");
    // print("SAVE offer Details ${model.toMap()}");
    await database.updateProductData(productModel!.productId, model).then((_){
      commonServices.cancelLoading();
      TextFieldActions.clearOfferTexts();
    });
  }

}