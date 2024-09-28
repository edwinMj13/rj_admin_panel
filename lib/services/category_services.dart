import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/category_model.dart';
import '../data/models/storage_image_model.dart';
import '../repository/common.dart';
import '../utils/common_methods.dart';
import '../view/providers/category_provider.dart';
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
  void _contextRefreshCategory(BuildContext context) {
    Navigator.pop(context);
    context.read<PickImageProvider>().fileSetToNull();
    context.read<CategoryProvider>().getCategoryProvider();
  }




}