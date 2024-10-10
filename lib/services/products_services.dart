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

class ProductServices {
  final formKeyProductAdd = GlobalKey<FormState>();
  final formKeyProductUpdate = GlobalKey<FormState>();
  CommonProvider commonProvider = CommonProvider();

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

  static setValuesToFields(ProductModel? model) {
    productDescriptionController.text = model!.description;
    ProductServices.subCategoryNotifier.value = model.subCategory!;
    productQuantityController.text = model.stock;
    productSellingPriceController.text = model.sellingPrize;
    productPriceController.text = model.price;
    productNameController.text = model.itemName;
    ProductServices.brandNotifier.value = model.itemBrand;
    ProductServices.categoryNotifier.value = model.category;
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
          subCategory: context.read<CommonProvider>().selectedSubCategory!,
          description: productDescriptionController.text,
        );
        context.read<ProductsProvider>().addProductData(model).then((_) {
          refresh(context);
          cleartextsAdd();
        });
      }
    }
    if (context.read<PickImageProvider>().multiple_Files.length < 2) {
      showSnackbar(context, "Select atleast 2 images");
    }
  }

  cleartextsAdd() {
    productDescriptionController.clear();
    productSubCategoryController.clear();
    productQuantityController.clear();
    productSellingPriceController.clear();
    productPriceController.clear();
    productNameController.clear();
    productBrandController.clear();
  }

  checkAndUpdate(BuildContext context, ProductModel? model,
      List<StorageImageModel> alreadyImage) async {
    int imageLength = context.read<PickImageProvider>().imagesUrl.length ;
    if (validateProductUpdate() && imageLength >= 2 && imageLength <= 6) {
      print("validateProductUpdate() && imageLength >= 2 && imageLength <= 6");
    //  if(context.read<PickImageProvider>().multiple_Files.isNotEmpty) {
        print("New FIles Added");
        // await getFirebaseStorageMULTIPLEImageUrl(
        //   context
        //       .read<PickImageProvider>()
        //       .multiple_Files,
        //   refName: "productIMages",
        //   productName: productNameController.text,
        // ).then((imageLIst) {

          //List<StorageImageModel> addData = [...alreadyImage, ...imageLIst];

          modelUpdate(context.read<PickImageProvider>().imagesUrl, model!, context);
       // });
     // }else{print("No New FIles Added OLD");
       // modelUpdate(alreadyImage, model!, context);
    //  }
    }else{
      showSnackbar(context, "Select exact no. of images");
    }
  }

  void modelUpdate(List<StorageImageModel> addData, ProductModel model,
      BuildContext context) {
    //print(addData[0].downloadUrl);

    final models = ProductModel(
      imagesList: addData,
      firebaseNodeId: model.firebaseNodeId,
      productId: model.firebaseNodeId,
      mainImage: addData[0].downloadUrl,
      //image: "image",
      itemName: productNameController.text,
      category: ProductServices.categoryNotifier.value,
      itemBrand: ProductServices.brandNotifier.value,
      price: productPriceController.text,
      sellingPrize: productSellingPriceController.text,
      stock: productQuantityController.text,
      status: "Selling",
      subCategory: ProductServices.subCategoryNotifier.value,
      description: productDescriptionController.text,
    );
    context
        .read<ProductsProvider>()
        .updateProductData(models, model.firebaseNodeId)
        .then((_) {
      cleartextsUpdate();
      refresh(context);
    });
  }

  cleartextsUpdate() {
    productEDITDescriptionController.clear();
    productEDITSubCategoryController.clear();
    productEDITQuantityController.clear();
    productEDITSellingPriceController.clear();
    productEDITPriceController.clear();
    productEDITNameController.clear();
    productEDITBrandController.clear();
  }

  cancelPopup(BuildContext context) {
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

  selectFromPopupDialog(
      String selectedValue, BuildContext context, String label) {
    if (label == "Brand") {
      ProductServices.updateBrand(selectedValue);
    }
    if (label == "Category") {
      commonProvider.getSubCategory(selectedValue);
      ProductServices.updateCategory(selectedValue);
      ProductServices.updateSubCategory("Select");
    }
    if (label == "Sub-Category") {
      ProductServices.updateSubCategory(selectedValue);
    }
    Navigator.of(context).pop();
  }

  static ValueNotifier<String> brandNotifier = ValueNotifier("Select");
  static ValueNotifier<String> categoryNotifier = ValueNotifier("Select");
  static ValueNotifier<String> subCategoryNotifier = ValueNotifier("Select");

  static ValueNotifier<List<String>> brandListNotifier = ValueNotifier([]);
  static ValueNotifier<List<String>> categoryListNotifier = ValueNotifier([]);
  static ValueNotifier<List<String>> subCategoryListNotifier =
      ValueNotifier([]);

  static updateBrand(String value) => brandNotifier.value = value;

  static updateCategory(String value) => categoryNotifier.value = value;

  static updateSubCategory(String value) => subCategoryNotifier.value = value;

  static getSubCategoryList(List<String> value) =>
      subCategoryListNotifier.value = value;

  static getCategoryList(List<String> value) =>
      categoryListNotifier.value = value;

  static getbrandList(List<String> value) => brandListNotifier.value = value;
}
