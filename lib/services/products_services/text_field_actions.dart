import 'package:flutter/cupertino.dart';
import 'package:project_rj_admin_panel/services/products_services/products_services.dart';
import 'package:project_rj_admin_panel/view/providers/pick_image_provider.dart';
import 'package:provider/provider.dart';

import '../../data/models/product_model.dart';
import '../../utils/text_controllers.dart';
import '../filter_services.dart';

 class TextFieldActions{
  static clearProductEditTextsUpdate() {
    productEDITDescriptionController.clear();
    productEDITSubCategoryController.clear();
    productEDITQuantityController.clear();
    productEDITSellingPriceController.clear();
    productEDITPriceController.clear();
    productEDITNameController.clear();
    productEDITBrandController.clear();
    productEDITMrpController.clear();
    clearNotifiers();
  }
  static clearTextsAdd() {
    productDescriptionController.clear();
    productSubCategoryController.clear();
    productQuantityController.clear();
    productSellingPriceController.clear();
    productPriceController.clear();
    productNameController.clear();
    productBrandController.clear();
    productMrpController.clear();
    clearNotifiers();
  }
 static clearNotifiers(){
    FilterServices.brandNotifier.value="Select";
    FilterServices.categoryNotifier.value="Select";
    FilterServices.subCategoryNotifier.value="Select";
  }

  static setValuesToFields(ProductModel? model) {
    productEDITDescriptionController.text = model!.description;
    FilterServices.subCategoryNotifier.value = model.subCategory!;
    productEDITQuantityController.text = model.stock;
    productEDITSellingPriceController.text = model.sellingPrize;
    productEDITPriceController.text = model.price;
    productEDITNameController.text = model.itemName;
    productEDITMrpController.text = model.itemMrp;
    FilterServices.brandNotifier.value = model.itemBrand;
    FilterServices.categoryNotifier.value = model.category;
  }

  static clearBrandTextADDUpdate(){
    popupEDITBrandNameController.clear();
    popupBrandNameController.clear();
  }

  static clearOfferTexts(){
    appDataProductLastAmountController.clear();
    appDataProductOfferPercentController.clear();
    appDataProductSalePriceController.clear();
    appDataProductMrpController.clear();
    appDataProductSearchController.clear();
  }
}