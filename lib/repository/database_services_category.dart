import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_rj_admin_panel/data/models/category_model.dart';

class DatabaseServicesCategory {
  final firebase = FirebaseFirestore.instance;

  addCategoryDetails(CategoryModel model) async {
    try {
      await firebase.collection("Categories").add(model.toMap()).then((node) async {
        final catModel = CategoryModel(
          imageRefPath: model.imageRefPath,
          fireID: node.id,
          id: model.id,
          status: model.status,
          image: model.image,
          categoryName: model.categoryName,
          subCategories: model.subCategories,
        );
        await firebase.collection("Categories").doc(node.id).update(catModel.toMap());
      }).catchError((e) {
        print("Error onThen Create Category :- ${e.toString()}");
      });
    } catch (e) {
      print("Create Category Exception :- ${e.toString()}");
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> model = [];
    try {
      final data = await firebase.collection("Categories").get();
      final categories = data.docs;

      model = categories.map((item) {
        return CategoryModel(
          subCategories: item.get("subCategories"),
          image: item["image"],
          imageRefPath: item.get("imageRefPath"),
          status: item.get("status"),
          id: item.get("id"),
          categoryName: item.get("categoryName"),
          fireID: item.get("fireID"),
        );
      }).toList();
      print(model.first.categoryName);
    } catch (e) {
      print("Read Category Exception :- ${e.toString()}");
    }
    return model;
  }

  Future<dynamic> getCategoryNames() async {
    final data=await firebase.collection("Categories").get();
    final listCategories=data.docs.map((item)=>item["categoryName"]).toList();
    print(listCategories);
    return listCategories;
  }

  Future<dynamic> getSubCategoryNames(String categoryName) async {
    List<CategoryModel> categoryList = await getCategories();
    CategoryModel qw = categoryList.where((model)=>model.categoryName==categoryName).first;
    print("List Sub  ${qw.subCategories}");
    return qw.subCategories;
  }

  updateCategory(CategoryModel model, String fireID) async {
    await firebase.collection("Categories").doc(fireID).update(model.toMap());
  }

  deleteCategory(String fireID) async {
    await firebase.collection("Categories").doc(fireID).delete();
  }
}
