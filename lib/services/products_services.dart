import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../data/models/product_model.dart';
import '../data/models/storage_image_model.dart';
import '../repository/common.dart';
import '../utils/common_methods.dart';
import '../utils/text_controllers.dart';
import '../view/providers/common_provider.dart';
import '../view/providers/pick_image_provider.dart';
import '../view/providers/products_provider.dart';

class ProductServices{
  final formKeyProductAdd = GlobalKey<FormState>();
  final formKeyProductUpdate = GlobalKey<FormState>();
  validateProductAdd() {
    final isTrue = formKeyProductAdd.currentState!.validate();
    if (isTrue) {
      return true;
    }
    return false;
  }
  validateProductUpdate() {
    final isTrue = formKeyProductUpdate.currentState!.validate();
    if (isTrue) {
      return true;
    }
    return false;
  }

  Future<void> checkAndAdd(BuildContext context) async {
    print("QWERTYHGFDS${context.read<CommonProvider>().selectedBrand!}");
    if (validateProductAdd()) {
      if (context.read<PickImageProvider>().multiple_Files.length >= 2) {
        List<StorageImageModel> imageLIst =
        await getFirebaseStorageMULTIPLEImageUrl(
          context.read<PickImageProvider>().multiple_Files,
          refName: "productIMages",
          productName: productNameController.text,
        );
        final model = ProductModel(
          imagesList: imageLIst,
          firebaseNodeId: "",
          productId: "",
          mainImage: imageLIst[0].downloadUrl,
          //image: "image",
          itemName: productNameController.text,
          category: context.read<CommonProvider>().selectedCategory!,
          itemBrand: context.read<CommonProvider>().selectedBrand!,
          price: productPriceController.text,
          sellingPrize: productSellingPriceController.text,
          stock: productQuantityController.text,
          status: "Selling",
          subCategory: context.read<CommonProvider>().selectedCategory!,
          description: productDescriptionController.text,
        );
        context.read<ProductsProvider>().addProductData(model).then((_) {
          refresh(context);
          cleartextsAdd();
        });
      }
    }
    if (context.read<PickImageProvider>().multiple_Files.length < 2){
      showSnackbar(context, "Select atleast 2 images");
    }
  }
  cleartextsAdd(){
    productDescriptionController.clear();
    productSubCategoryController.clear();
    productQuantityController.clear();
    productSellingPriceController.clear();
    productPriceController.clear();
    productNameController.clear();
    productBrandController.clear();
  }

  checkAndUpdate(BuildContext context, ProductModel? model, List<StorageImageModel> alreadyImage) async {
    int imageLength = context.read<PickImageProvider>().multiple_Files.length +
        model!.imagesList.length;
    if (validateProductUpdate() && imageLength >= 2 && imageLength<=6) {
      List<StorageImageModel> imageLIst =
      await getFirebaseStorageMULTIPLEImageUrl(
        context.read<PickImageProvider>().multiple_Files,
        refName: "productIMages",
        productName: productNameController.text,
      );

      List<StorageImageModel> addData=[...alreadyImage,...imageLIst];
      print("imageLIst Length ${imageLIst.length}\n"
          "imageLIst ${imageLIst}");
      print("model!.imagesList  ${model.imagesList.length}\n"
          "model!.imagesList  ${model.imagesList}");
      print("addData  ${addData}");

      final models = ProductModel(
        imagesList: addData,
        firebaseNodeId: model.firebaseNodeId,
        productId: model.firebaseNodeId,
        mainImage: addData[0].downloadUrl,
        //image: "image",
        itemName: productNameController.text,
        category: context.read<CommonProvider>().selectedCategory!,
        itemBrand: context.read<CommonProvider>().selectedBrand!,
        price: productPriceController.text,
        sellingPrize: productSellingPriceController.text,
        stock: productQuantityController.text,
        status: "Selling",
        subCategory: context.read<CommonProvider>().selectedCategory!,
        description: productDescriptionController.text,
      );
      context.read<ProductsProvider>().updateProductData(models,model.firebaseNodeId).then((_) {
        cleartextsUpdate();
        refresh(context);
      });
    }
  }

  cleartextsUpdate(){
    productEDITDescriptionController.clear();
    productEDITSubCategoryController.clear();
    productEDITQuantityController.clear();
    productEDITSellingPriceController.clear();
    productEDITPriceController.clear();
    productEDITNameController.clear();
    productEDITBrandController.clear();
  }

  cancelPopup(BuildContext context){
    cleartextsUpdate();
    cleartextsAdd();
    context.read<PickImageProvider>().fileSetToNull();
    Navigator.of(context).pop();
  }

  void refresh(BuildContext context) {
    cancelPopup(context);
    context.read<PickImageProvider>().fileSetToNull();
    context.read<ProductsProvider>().getProductsDataProvider();
  }

  onDeletePress(String firebaseNodeId, BuildContext context) {
    context.read<ProductsProvider>().deleteProductDataProvider(firebaseNodeId);
  }
}