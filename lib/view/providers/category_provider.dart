import 'package:flutter/cupertino.dart';
import 'package:project_rj_admin_panel/data/models/category_model.dart';
import 'package:project_rj_admin_panel/repository/database_services_category.dart';

import '../../repository/database_services_brand.dart';

class CategoryProvider extends ChangeNotifier{

  List<CategoryModel>? _cateModel;
  List<CategoryModel>? get cateModel =>_cateModel;

  final List<String> _subCategoryChip=[];
  List<String>  get subCategoryChip =>_subCategoryChip;

  CategoryModel? _categoryModel;
  CategoryModel? get categoryModel=>_categoryModel;


  List<String> _subListProducts=[];
  List<String>  get subListProducts =>_subListProducts;

  final dBservices=DatabaseServicesCategory();

  // final List<String> _subCategoryChipEDIT=[];
  // List<String>  get subCategoryChipEDIT =>_subCategoryChipEDIT;

  addToSubCategory(String sub){
    _subCategoryChip.add(sub);
    notifyListeners();
    print("addToSubCategory $sub");
  }

  clearCategoryList(){
    _subCategoryChip.clear();
    print("$_subCategoryChip$subCategoryChip");
  }

  deleteSubCtaegory(int index){
    _subCategoryChip.removeAt(index);
    notifyListeners();
  }

  addCategoryDetails(CategoryModel model) async {
    await dBservices.addCategoryDetails(model);
  }

  getCategoryProvider() async {
    _cateModel=await dBservices.getCategories();
    notifyListeners();
  }

  editCategory(CategoryModel model){
    _categoryModel=model;
  }
  Future<void> updateCategoryDetails(CategoryModel model, String fireID) async {
    await dBservices.updateCategory(model,fireID);
  }
  Future<void> deleteCategoryDetail(String id) async {
    await dBservices.deleteCategory(id);
    getCategoryProvider();
  }



}
