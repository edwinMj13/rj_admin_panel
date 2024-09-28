import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/utils/common_methods.dart';
import 'package:provider/provider.dart';

import '../data/models/brand_model.dart';
import '../data/models/storage_image_model.dart';
import '../repository/common.dart';
import '../view/providers/brand_provider.dart';
import '../view/providers/home_provider.dart';
import '../view/providers/pick_image_provider.dart';
import '../view/widgets/popupcard_title_image_widget.dart';

class BrandServices {
  final formKeyAddBrand = GlobalKey<FormState>();
  final formKeyUpdateBrand = GlobalKey<FormState>();
  Uint8List? unitImage;

  validateAddForm() {
    final isOk = formKeyAddBrand.currentState!.validate();
    if (isOk) {
      return true;
    }
    return false;
  }

  validateUpdateForm() {
    final isOk = formKeyUpdateBrand.currentState!.validate();
    if (isOk) {
      return true;
    }
    return false;
  }

  saveTtoString(BuildContext context) {
    unitImage = context.read<PickImageProvider>().imageFile!.bytes;
  }

  checkAndAddBrand(String name, BuildContext context) async {
    //print("object");
    if (validateAddForm() &&
        context.read<PickImageProvider>().imageFile!.bytes != null) {
      final image = context.read<PickImageProvider>().imageFile!.bytes;
      StorageImageModel imageUrl =
          await getFirebaseStorageImageUrl(image!, 'brands');
      final brandId = await createBrandId();
      final model = BrandModel(
        imageRefPath: imageUrl.storageRefPath,
        nodeId: "",
        image: imageUrl.downloadUrl,
        id: brandId,
        name: name,
        status: 'Available',
      );
      await context
          .read<BrandProvider>()
          .uploadBrandDetails(model, () => _contextRefresh(context));
    } else if (context.read<PickImageProvider>().imageFile == null) {
      showSnackbar(context, "Please Add Icon");
    }
  }

  void _contextRefresh(BuildContext context) {
    context.read<BrandProvider>().getBrandsProvider();
    context.read<PickImageProvider>().fileSetToNull();
    Navigator.pop(context);
  }

  Future<int> createBrandId() async {
    //List<BrandModel> model=[];
    final refData = await FirebaseFirestore.instance.collection('Brands').get();
    final data = refData.docs;
    List model = data
        .map(
          (e) => e.get('id'),
        )
        .toList();
    model.sort();
    int id = 1001;
    if (model.isNotEmpty) {
      int str = model.last;
      id = str + 1;
    }
    // print(model.last);
    return id;
  }

  checkAndUpdateBrand(
      String name, BuildContext context, BrandModel model) async {
    //print("object");
    if (validateUpdateForm() && model.image != null && unitImage == null) {
      final modelBrand = BrandModel(
        imageRefPath: model.imageRefPath,
        nodeId: model.nodeId,
        image: model.image,
        id: model.id,
        name: name,
        status: model.status,
      );
      await context.read<BrandProvider>().editBrandDetails(
          modelBrand, model.nodeId, () => _contextRefresh(context));
    } else if (unitImage != null) {
      StorageImageModel imageData =
          await getFirebaseStorageImageUrl(unitImage!, 'brands');
      final modelBrand = BrandModel(
        imageRefPath: imageData.storageRefPath,
        nodeId: model.nodeId,
        image: imageData.downloadUrl,
        id: model.id,
        name: name,
        status: model.status,
      );
      await context.read<BrandProvider>().editBrandDetails(
          modelBrand, model.nodeId, () => _contextRefresh(context));
    }
  }

  onDeletePress(BuildContext context, String nodeId) {
    context.read<BrandProvider>().deleteBrandDetails(nodeId);
  }

  void onEditPress(BuildContext context, BrandModel model) {
    final label = getScreenLabel(context.read<HomeProvider>().index);
    //context.read<SubjectBloc>()
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0.0),
            content: PopupCardTitleImageWidget(
              title: "Edit Brand",
              model: model,
              labelText: label,
            ),
          );
        });
  }
}
