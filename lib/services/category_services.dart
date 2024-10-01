import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/utils/text_controllers.dart';
import 'package:provider/provider.dart';

import '../data/models/category_model.dart';
import '../data/models/storage_image_model.dart';
import '../repository/common.dart';
import '../utils/common_methods.dart';
import '../view/providers/category_provider.dart';
import '../view/providers/common_provider.dart';
import '../view/providers/pick_image_provider.dart';

class CategoryServices {

  final formKeyCategoryAdd = GlobalKey<FormState>();
  final formKeyCategoryUpdate = GlobalKey<FormState>();
  Uint8List? uintImage;

  validateFormAdd() {
    final isOk = formKeyCategoryAdd.currentState!.validate();
    if (isOk) {
      return true;
    }
    return false;
  }

  validateFormUpdate() {
    final isOk = formKeyCategoryUpdate.currentState!.validate();
    if (isOk) {
      return true;
    }
    return false;
  }

  saveImageToCheck(BuildContext context) {
    uintImage = context.read<PickImageProvider>().imageFile!.bytes;
  }

  //Add Category
  checkAndAddCategory(String name, BuildContext context) async {
    final subCtaegoryList = context.read<CategoryProvider>().subCategoryChip;
    final categoryId = await createCategoryId();

    if (validateFormAdd() && context.read<PickImageProvider>().imageFile != null) {
      final image = context.read<PickImageProvider>().imageFile!.bytes;
      print("addCategoryDetails");
      StorageImageModel imageData =
      await getFirebaseStorageImageUrl(image, 'categories');
      print("ADD With ADD");
      await addCategory(categoryId, name, subCtaegoryList, imageData, context);
    } else if (context.read<PickImageProvider>().imageFile == null) {
      showSnackbar(context, "Image Cannot be empty!");
    }
  }
  Future<void> addCategory(
      int categoryId,
      String name,
      List<String> subCtaegoryList,
      StorageImageModel storageModel,
      BuildContext context) async {
    final model = CategoryModel(
        imageRefPath: storageModel.storageRefPath,
        id: categoryId,
        status: "Available",
        categoryName: name,
        subCategories: subCtaegoryList,
        image: storageModel.downloadUrl,
        fireID: '');
    await context
        .read<CategoryProvider>()
        .addCategoryDetails(model)
        .then((value) {
      context.read<PickImageProvider>().imageFile != null;
      _contextRefreshCategory(context);
    });
  }

  clearFields(BuildContext context){
    Navigator.pop(context);
    context.read<PickImageProvider>().fileSetToNull();
    popupCategoryNameController.text="";
    popupSub_CategoryNameController.text="";
    context.read<CategoryProvider>().clearCategoryList();
  }

  void _contextRefreshCategory(BuildContext context) {
    clearFields(context);
    context.read<CategoryProvider>().getCategoryProvider();
    context.read<CommonProvider>().getCategoryNames();
  }


  checkAndUpdateCategory(String name, BuildContext context, CategoryModel? model) async {
    final subCategoryList = context.read<CategoryProvider>().subCategoryChip;

    if (validateFormUpdate() && uintImage != null) {
      print("addCategoryDetails");
      StorageImageModel imageData = await getFirebaseStorageImageUrl(uintImage, 'categories');
      print("Update With imageUrl EDIT");
      await updateCategoryUNI(name, subCategoryList, imageData, context,model);
    } else if (validateFormUpdate() &&
        context.read<PickImageProvider>().imageFile == null) {
      print("Update With ${model!.fireID} EDIT");
      final catModel = CategoryModel(
          imageRefPath: model.imageRefPath,
          id: model.id,
          status: model.status,
          categoryName: name,
          subCategories: subCategoryList,
          image: model.image,
          fireID: model.fireID);
      await context
          .read<CategoryProvider>()
          .updateCategoryDetails(catModel, model.fireID)
          .then((value) {
        context.read<PickImageProvider>().imageFile != null;
        _contextRefreshCategory(context);
      });
    }
  }

  Future<void> updateCategoryUNI(String name, List<String> subCtaegoryList,
      StorageImageModel imgData, BuildContext context,CategoryModel? model) async {
    final catModel = CategoryModel(
        imageRefPath: imgData.storageRefPath,
        id: model!.id,
        status: model.status,
        categoryName: name,
        subCategories: subCtaegoryList,
        image: imgData.downloadUrl,
        fireID: model.fireID);
    await context
        .read<CategoryProvider>()
        .updateCategoryDetails(catModel, model.fireID)
        .then((value) {
      context.read<PickImageProvider>().imageFile != null;
      _contextRefreshCategory(context);
    });
  }
  onDeletePress(BuildContext context, String fireID,) {
    context.read<CategoryProvider>().deleteCategoryDetail(fireID);
    context.read<CommonProvider>().getCategoryNames();
  }
}