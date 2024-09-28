
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_rj_admin_panel/data/models/brand_model.dart';
import 'package:project_rj_admin_panel/data/models/storage_image_model.dart';

Future<StorageImageModel> getFirebaseStorageImageUrl(Uint8List? image,String refName) async {
  var imageName = DateTime.now().millisecondsSinceEpoch.toString();
  var storageRef = FirebaseStorage.instance.ref().child('$refName/$imageName.jpg');
  print("Storage Ref$storageRef");
  var uploadTask = storageRef.putData(image!);
  var downloadUrl = await (await uploadTask).ref.getDownloadURL();
  final storageImageData=StorageImageModel(storageRefPath: "$refName/$imageName.jpg", downloadUrl: downloadUrl);
  return storageImageData;
}

Future<List<StorageImageModel>> getFirebaseStorageMULTIPLEImageUrl(List<Uint8List>? imageList,{String refName="",String productName=""}) async {
  final  List<StorageImageModel> storageImageData=[];
  for(Uint8List item in imageList!){
  var imageName = DateTime.now().millisecondsSinceEpoch.toString();
  var storageRef = FirebaseStorage.instance.ref().child('$refName/$productName/$imageName.jpg');
  print("Storage Ref$storageRef");
  var uploadTask = storageRef.putData(item);
  var downloadUrl = await (await uploadTask).ref.getDownloadURL();
  storageImageData.add(StorageImageModel(storageRefPath: "$refName/$imageName.jpg", downloadUrl: downloadUrl));
  }
  return storageImageData;
}

Future<void> deleteFileStorage(String path) async {
  final firebaseStorage=FirebaseStorage.instance;
 await firebaseStorage.ref(path).delete();
}

Future<int> createCategoryId() async {
  //List<BrandModel> model=[];
  final refData=await FirebaseFirestore.instance.collection('Categories').get();
  final data=refData.docs;
  List model= data.map((e)=>e.get('id'),).toList();
  model.sort();
  int id=4001;
  if(model.isNotEmpty){
    int str=model.last;
    id=str+1;
  }
  //print(model.last);
  return id;
}
