
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String getScreenTag(int index){
switch(index){
  case 1:
    return "Add Product";
  case 2:
    return "Add Category";
  case 3:
    return "Add Brand";
  case 4:
    return "Add Coupon";
  case 5:
    return "Order Details";
    default:
      return "";
}
}
String getScreenLabel(int index){
  switch(index){
    // case 1:
    //   return "Add Product";
    case 2:
      return "Category Name";
    case 3:
      return "Brand Name";
    case 4:
      return "Add Coupon";
    // case 5:
    //   return "Order Details";
    default:
      return "";
  }
}

String getSubSectionsCategory(int index){
  switch(index){
    case 0:
      return "Category";
    case 1:
      return "Sub-Category";
    case 2:
      return "Variant-Type";
    case 3:
      return "Variant-Item";
    default:
      return "";
  }
}


showSnackbar(BuildContext context,String title){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
}

