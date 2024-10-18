import 'package:flutter/cupertino.dart';
import 'package:project_rj_admin_panel/data/models/category_model.dart';
import 'package:project_rj_admin_panel/services/common_services.dart';
import 'package:project_rj_admin_panel/services/filter_services.dart';
import 'package:project_rj_admin_panel/services/products_services/text_field_actions.dart';
import 'package:provider/provider.dart';

import '../../data/models/product_model.dart';
import '../../data/models/storage_image_model.dart';
import '../../repository/common.dart';
import '../../utils/common_methods.dart';
import '../../utils/text_controllers.dart';
import '../../view/providers/common_provider.dart';
import '../../view/providers/pick_image_provider.dart';
import '../../view/providers/products_provider.dart';

class ProductServices {
  final formKeyProductAdd = GlobalKey<FormState>();
  final formKeyProductUpdate = GlobalKey<FormState>();

  CommonServices commonServices = CommonServices();

  validateProductAdd() {
    final isTrue = formKeyProductAdd.currentState!.validate();
    if (isTrue == true &&
        FilterServices.brandNotifier.value != "Select" &&
        FilterServices.categoryNotifier.value != "Select" &&
        FilterServices.subCategoryNotifier.value != "Select") {
      return true;
    }
    return false;
  }

  validateProductUpdate() {
    final isTrue = formKeyProductUpdate.currentState!.validate();
    if (isTrue == true &&
        FilterServices.brandNotifier.value != "Select" &&
        FilterServices.categoryNotifier.value != "Select" &&
        FilterServices.subCategoryNotifier.value != "Select") {
      return true;
    }
    return false;
  }

  checkAndAdd(BuildContext context) async {
    // print("QWERTYHGFDS${context.read<CommonProvider>().selectedBrand!}");
    if (validateProductAdd()) {
      if (context.read<PickImageProvider>().imagesUrl.length >= 2) {
        commonServices.loadingDialogShow(context);

        final model = ProductModel(
          imagesList: context.read<PickImageProvider>().imagesUrl,
          firebaseNodeId: "",
          itemMrp: productMrpController.text,
          productId: "",
          mainImage: context.read<PickImageProvider>().imagesUrl[0].downloadUrl,
          //image: "image",
          itemName: productNameController.text,
          category: FilterServices.categoryNotifier.value,
          itemBrand: FilterServices.brandNotifier.value,
          price: productPriceController.text,
          sellingPrize: productSellingPriceController.text,
          stock: productQuantityController.text,
          status: "Selling",
          subCategory: FilterServices.subCategoryNotifier.value,
          description: productDescriptionController.text,
        );
        await context.read<ProductsProvider>().addProductData(model,()=>actionAfterAddUpdate(context));
      }
    }
    if (context.read<PickImageProvider>().multiple_Files.length < 2) {
      showSnackbar(context, "Select atleast 2 images");
    }
  }

  checkAndUpdate(BuildContext context, ProductModel? model) async {
    commonServices.loadingDialogShow(context);

    int imageLength = context.read<PickImageProvider>().imagesUrl.length;
    if (validateProductUpdate() && imageLength >= 2 && imageLength <= 6) {
      print("validateProductUpdate() && imageLength >= 2 && imageLength <= 6");
      print("New FIles Added");

      modelUpdate(context.read<PickImageProvider>().imagesUrl, model!, context);
    } else {
      showSnackbar(context, "Select exact no. of images");
    }
  }

  modelUpdate(List<StorageImageModel> addData, ProductModel model,
      BuildContext context) async {
    final models = ProductModel(
      imagesList: addData,
      firebaseNodeId: model.firebaseNodeId,
      itemMrp: productEDITMrpController.text,
      productId: model.firebaseNodeId,
      mainImage: addData[0].downloadUrl,
      //image: "image",
      itemName: productNameController.text,
      category: FilterServices.categoryNotifier.value,
      itemBrand: FilterServices.brandNotifier.value,
      price: productPriceController.text,
      sellingPrize: productSellingPriceController.text,
      stock: productQuantityController.text,
      status: model.status,
      subCategory: FilterServices.subCategoryNotifier.value,
      description: productDescriptionController.text,
    );
    await context
        .read<ProductsProvider>()
        .updateProductData(models, model.firebaseNodeId, () => actionAfterAddUpdate(context));
  }

  actionAfterAddUpdate(BuildContext context) {
    commonServices.cancelLoading();
    TextFieldActions.clearProductEditTextsUpdate(context);
    refresh(context);
  }

  cancelPopup(BuildContext context) {
    Navigator.of(context).pop();
    context.read<PickImageProvider>().fileSetToNull();
    TextFieldActions.clearProductEditTextsUpdate(context);
    TextFieldActions.clearTextsAdd(context);
  }

  void refresh(BuildContext context) {
    cancelPopup(context);
    context.read<PickImageProvider>().fileSetToNull();
    context.read<ProductsProvider>().getProductsDataProvider();
  }

  onDeletePress(String firebaseNodeId, BuildContext context) {
    context.read<ProductsProvider>().deleteProductDataProvider(firebaseNodeId);
  }

  updateStatusCategory(BuildContext context, ProductModel model) async {
    await context
        .read<ProductsProvider>()
        .updateProductData(model, model.firebaseNodeId, () => refresh(context));
  }
}
