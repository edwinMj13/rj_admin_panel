import 'package:flutter/cupertino.dart';
import 'package:project_rj_admin_panel/data/models/category_model.dart';
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

  CommonProvider commonProvider = CommonProvider();

  validateProductAdd() {
    final isTrue = formKeyProductAdd.currentState!.validate();
    if (isTrue==true &&
        FilterServices.brandNotifier.value != "Select" &&
        FilterServices.categoryNotifier.value != "Select" &&
        FilterServices.subCategoryNotifier.value !="Select") {
      return true;
    }
    return false;
  }

  validateProductUpdate() {
    final isTrue = formKeyProductUpdate.currentState!.validate();
    if (isTrue==true && FilterServices.brandNotifier.value != "Select" &&
        FilterServices.categoryNotifier.value != "Select" &&
        FilterServices.subCategoryNotifier.value !="Select") {
      return true;
    }
    return false;
  }

  Future<void> checkAndAdd(BuildContext context) async {
    // print("QWERTYHGFDS${context.read<CommonProvider>().selectedBrand!}");
    if (validateProductAdd()) {
      if (context.read<PickImageProvider>().imagesUrl.length >= 2) {
        final model = ProductModel(
          imagesList: context.read<PickImageProvider>().imagesUrl,
          firebaseNodeId: "",
          productId: "",
          mainImage: context.read<PickImageProvider>().imagesUrl[0].downloadUrl,
          //image: "image",
          itemName: productNameController.text,
          category: FilterServices.categoryNotifier.value,
          itemBrand: FilterServices.categoryNotifier.value,
          price: productPriceController.text,
          sellingPrize: productSellingPriceController.text,
          stock: productQuantityController.text,
          status: "Selling",
          subCategory: FilterServices.categoryNotifier.value,
          description: productDescriptionController.text,
        );
        context.read<ProductsProvider>().addProductData(model).then((_) {
          refresh(context);
          TextFieldActions.clearTextsAdd(context);
        });
      }
    }
    if (context.read<PickImageProvider>().multiple_Files.length < 2) {
      showSnackbar(context, "Select atleast 2 images");
    }
  }

  checkAndUpdate(BuildContext context, ProductModel? model,
      List<StorageImageModel> alreadyImage) async {
    int imageLength = context.read<PickImageProvider>().imagesUrl.length;
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
    } else {
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
      category: FilterServices.categoryNotifier.value,
      itemBrand: FilterServices.brandNotifier.value,
      price: productPriceController.text,
      sellingPrize: productSellingPriceController.text,
      stock: productQuantityController.text,
      status: "Selling",
      subCategory: FilterServices.subCategoryNotifier.value,
      description: productDescriptionController.text,
    );
    context
        .read<ProductsProvider>()
        .updateProductData(models, model.firebaseNodeId)
        .then((_) {
      TextFieldActions.clearTextsUpdate(context);
      refresh(context);
    });
  }

  cancelPopup(BuildContext context) {
    Navigator.of(context).pop();
    context.read<PickImageProvider>().fileSetToNull();
    TextFieldActions.clearTextsUpdate(context);
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

  void updateStatusCategory(BuildContext context, ProductModel model) {
    context.read<ProductsProvider>().updateProductData(model, model.firebaseNodeId).then((_){
      context.read<ProductsProvider>().getProductsDataProvider();
      Navigator.of(context).pop();
    });
  }
}
