import 'package:flutter/cupertino.dart';
import 'package:project_rj_admin_panel/services/products_services/products_services.dart';
import 'package:project_rj_admin_panel/view/providers/pick_image_provider.dart';
import 'package:provider/provider.dart';

import '../../data/models/product_model.dart';
import '../../utils/text_controllers.dart';
import '../filter_services.dart';

 class TextFieldActions{
  static clearProductEditTextsUpdate(BuildContext context) {
    productEDITDescriptionController.clear();
    productEDITSubCategoryController.clear();
    productEDITQuantityController.clear();
    productEDITSellingPriceController.clear();
    productEDITPriceController.clear();
    productEDITNameController.clear();
    productEDITBrandController.clear();
    context.read<PickImageProvider>().addToImages([]);
    clearNotifiers();
  }
  static clearTextsAdd(BuildContext context) {
    productDescriptionController.clear();
    productSubCategoryController.clear();
    productQuantityController.clear();
    productSellingPriceController.clear();
    productPriceController.clear();
    productNameController.clear();
    productBrandController.clear();
    context.read<PickImageProvider>().addToImages([]);
    clearNotifiers();
  }
 static clearNotifiers(){
    FilterServices.brandNotifier.value="Select";
    FilterServices.categoryNotifier.value="Select";
    FilterServices.subCategoryNotifier.value="Select";
  }

  static setValuesToFields(ProductModel? model) {
    productDescriptionController.text = model!.description;
    FilterServices.subCategoryNotifier.value = model.subCategory!;
    productQuantityController.text = model.stock;
    productSellingPriceController.text = model.sellingPrize;
    productPriceController.text = model.price;
    productNameController.text = model.itemName;
    FilterServices.brandNotifier.value = model.itemBrand;
    FilterServices.categoryNotifier.value = model.category;
  }

  static clearBrandTextADDUpdate(){
    popupEDITBrandNameController.clear();
    popupBrandNameController.clear();
  }
}