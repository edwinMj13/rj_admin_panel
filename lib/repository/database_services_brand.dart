import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_rj_admin_panel/data/models/brand_model.dart';
import 'package:project_rj_admin_panel/data/models/category_model.dart';

import '../view/providers/common_provider.dart';

class DatabaseServicesBrand {
  final firebase = FirebaseFirestore.instance;

  Future<void> addBrandDetails(BrandModel model) async {
    // var imageName = DateTime.now().millisecondsSinceEpoch.toString();
    // var storageRef = FirebaseStorage.instance.ref().child('brand/$imageName.jpg');
    // var uploadTask = storageRef.putData(image!);
    // var downloadUrl = await (await uploadTask).ref.getDownloadURL();
    // print(name);
    // BrandModel brandModel=BrandModel(name: name,id: '2654QW',status: 'Available',image: downloadUrl);
    // createBrand(brandModel);
    try {
      await firebase.collection("Brands").add(model.toMap()).then((node) {
        final updadte = BrandModel(
          imageRefPath: model.imageRefPath,
          id: model.id,
          image: model.image,
          status: model.status,
          name: model.name,
          nodeId: node.id,
        );
        firebase.collection("Brands").doc(node.id).update(updadte.toMap());
      });
    } catch (e) {
      print("Create Brand Exception ${e.toString()}");
    }
  }

  Future<List<BrandModel>> getBrands() async {
    List<BrandModel> model = [];
    try {
      final data = await firebase.collection("Brands").get();
      final brand = data.docs;
      model = brand
          .map(
            (model) => BrandModel(
              imageRefPath: model.get("imageRefPath"),
              nodeId: model.get("nodeId"),
              image: model["image"],
              status: model.get("status"),
              id: model.get("id"),
              name: model.get("name"),
            ),
          )
          .toList();
      //print(model.first.name);
    } catch (e) {
      print("Read Brand Exception ${e.toString()}");
    }
    return model;
  }

  Future<dynamic> getBrandsNames() async {
    final data=await firebase.collection("Brands").get();
    final listBrands=data.docs.map((item)=>item["name"]).toList();
    print(listBrands);
    return listBrands;
  }

  Future<void> editBrandDetails(BrandModel model, String nodeId) async {
    await firebase.collection("Brands").doc(nodeId).update(model.toMap());
  }

  Future<void> deleteBrandDetails(String nodeId) async {
    await firebase.collection("Brands").doc(nodeId).delete();
  }
}
