import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/storage_image_model.dart';

class ProductModel {

  final String firebaseNodeId;
 // final String image;
  final String itemName;
  final String itemBrand;
  final String category;
  final String? subCategory;
  final String price;
  final String sellingPrize;
  final String stock;
  final String status;
  final String description;
  final String productId;
  final String? mainImage;
  final List<dynamic> imagesList;

  ProductModel({
    required this.firebaseNodeId,
    required this.imagesList,
    required this.itemName,
    required this.category,
    required this.itemBrand,
    this.subCategory,
    required this.price,
    required this.sellingPrize,
    required this.productId,
    this.mainImage,
    required this.stock,
     required this.status,
    required this.description,
  });


  Map<String, dynamic> toMap(){
    return {
      "firebaseNodeId":firebaseNodeId,
      "itemName":itemName,
      "category":category,
      "subCategory":subCategory,
      "price":price,
      "sellingPrize":sellingPrize,
      "mainImage":mainImage,
      "status":status,
      "itemBrand":itemBrand,
      "productId":productId,
      "stock":stock,
      "description":description,
      "imagesList":imagesList.map((image)=>image.toMap()),
    };
  }
}



List<String> productsTableTitle=[
  "Image",
  "Product Name",
  "Category",
  "Price",
  "Sale Price",
  "Stock",
  "Status",
  "Actions",
];







/*
List<ProductTableDataModel> productTableData = [
  ProductTableDataModel("8138qw", Icons.notifications, "Cellar Calling Bell", "Home Appliances", "Alarms",
      200, 180, 259, "Available", 'A Calling bell suitable for many thing'),
  ProductTableDataModel("8138qw", Icons.notifications, "Cellar Calling Bell", "Home Appliances", "Alarms",
      200, 180, 259, "Available", 'A Calling bell suitable for many thing'),
  ProductTableDataModel("8138qw", Icons.notifications, "Cellar Calling Bell", "Home Appliances", "Alarms",
      200, 180, 259, "Available", 'A Calling bell suitable for many thing'),
  ProductTableDataModel("8138qw", Icons.notifications, "Cellar Calling Bell", "Home Appliances", "Alarms",
      200, 180, 259, "Available", 'A Calling bell suitable for many thing'),
  ProductTableDataModel("8138qw", Icons.notifications, "Cellar Calling Bell", "Home Appliances", "Alarms",
      200, 180, 259, "Available", 'A Calling bell suitable for many thing'),
];

*/

