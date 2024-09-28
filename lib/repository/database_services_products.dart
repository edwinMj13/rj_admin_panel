import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_rj_admin_panel/data/models/product_model.dart';

class DatabaseServicesProducts {
  final firebase = FirebaseFirestore.instance;

  uploadProductData(ProductModel model) async {
    try {
      await firebase
          .collection("Products")
          .add(model.toMap())
          .then((nodeId) async {
        final prodModel = ProductModel(
          itemBrand: model.itemBrand,
          imagesList: model.imagesList,
          firebaseNodeId: nodeId.id,
          //image: model.image,
          itemName: model.itemName,
          category: model.category,
          price: model.price,
          status: model.status,
          subCategory: model.subCategory,
          sellingPrize: model.sellingPrize,
          stock: model.stock,
          description: model.description,
        );
        await firebase
            .collection("Products")
            .doc(nodeId.id)
            .update(prodModel.toMap());
      });
    } catch (e) {
      print("Create Products ${e.toString()}");
    }
  }

  Future<List<ProductModel>> getProductsData() async {
    List<ProductModel> productList = [];
    try {
      final doc = await firebase.collection("Products").get();
      final data = doc.docs;
      productList = data
          .map((e) => ProductModel(
                imagesList: e.get("imagesList"),
                itemBrand: e.get("itemBrand"),
                firebaseNodeId: e.get("firebaseNodeId"),
                // image: e.get("image"),
                itemName: e.get("itemName"),
                status: e.get("status"),
                category: e.get("category"),
                subCategory: e.get("subCategory"),
                price: e.get("price"),
                sellingPrize: e.get("sellingPrize"),
                stock: e.get("stock"),
                description: e.get("description"),
              ))
          .toList();
    } catch (e) {
      print("Read Products ${e.toString()}");
    }
    return productList;
  }


  Future<void> updateProductData(String nodeId,ProductModel model)async{
    try {
      await firebase.collection("Products").doc(nodeId).update(model.toMap());
    }catch(e){
      print("updateProductData Exception - ${e.toString()}");
    }
  }

  Future<void> deleteProduct(String nodeId) async {
    await firebase.collection("Products").doc(nodeId).delete();
  }

}
