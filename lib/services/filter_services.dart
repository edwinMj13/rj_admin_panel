import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/services/common_services.dart';
import 'package:project_rj_admin_panel/view/providers/common_provider.dart';
import 'package:provider/provider.dart';

class FilterServices{
  static ValueNotifier<String> brandNotifier = ValueNotifier("Select");
  static ValueNotifier<String> categoryNotifier = ValueNotifier("Select");
  static ValueNotifier<String> subCategoryNotifier = ValueNotifier("Select");

  static ValueNotifier<List<String>> brandListNotifier = ValueNotifier([]);
  static ValueNotifier<List<String>> categoryListNotifier = ValueNotifier([]);
  static ValueNotifier<List<String>> subCategoryListNotifier =
  ValueNotifier([]);

  static updateBrand(String value) => brandNotifier.value = value;

  static updateCategory(String value) => categoryNotifier.value = value;

  static updateSubCategory(String value) => subCategoryNotifier.value = value;

  static getSubCategoryList(List<String> value) =>
      subCategoryListNotifier.value = value;

  static getCategoryList(List<String> value) =>
      categoryListNotifier.value = value;

  static getbrandList(List<String> value) => brandListNotifier.value = value;

  static selectFromPopupDialog(
      String selectedValue, BuildContext context, String label) {
    if (label == "Brand") {
      updateBrand(selectedValue);
    }
    if (label == "Category") {
      context.read<CommonProvider>().getSubCategory(selectedValue);
      updateCategory(selectedValue);
      updateSubCategory("Select");
    }
    if (label == "Sub-Category") {
      updateSubCategory(selectedValue);
    }
    Navigator.of(context).pop();
  }

  static List<String> populateCatBrandList(BuildContext context, String label) {
    List<String> listTwo = [];
    if (label == "Brand") {
      context.read<CommonProvider>().getBrandsNames();
      listTwo = context.read<CommonProvider>().brandsNames!;
    } else if (label == "Category") {
      context.read<CommonProvider>().getCategoryNames();
      listTwo = context.read<CommonProvider>().categoryNames!;
    }
    return listTwo;
  }

}