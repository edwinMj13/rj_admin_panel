import 'package:flutter/cupertino.dart';
import 'package:project_rj_admin_panel/repository/database_services_brand.dart';
import 'package:project_rj_admin_panel/repository/database_services_category.dart';
import 'package:project_rj_admin_panel/services/products_services.dart';

class CommonProvider extends ChangeNotifier{

  final dBservicesBrand = DatabaseServicesBrand();
  final dBservicesCategory = DatabaseServicesCategory();

  List<String> _subListProducts=[];
  List<String> get subListProducts=>_subListProducts;

  List<String>? _brandsNames=[];
  List<String>? get brandsNames => _brandsNames;

  List<String>? _categoryNames=[];
  List<String>? get categoryNames => _categoryNames;

  String? selectedBrand,selectedCategory,selectedSubCategory;


   getCategoryNames() async {
    List<dynamic> list = await dBservicesCategory.getCategoryNames();
    _categoryNames = list.cast<String>();
   }

  getSubCategory(String catName)  async {
     _subListProducts.clear();
     subListProducts.clear();
    List<dynamic> list = await dBservicesCategory.getSubCategoryNames(catName);
    _subListProducts = list.cast<String>();
    ProductServices.getSubCategoryList(_subListProducts);
    notifyListeners();
  }

  selectedItemString(String tag,String item){
     if(tag=="b"){
       selectedBrand=item;
     }else if(tag=="c"){
       selectedCategory=item;
     }else if(tag=="s"){
       selectedSubCategory=item;
     }

  }


  refresh(){
    notifyListeners();
  }

   getBrandsNames() async {
     List<dynamic> list= await dBservicesBrand.getBrandsNames();
     _brandsNames=list.cast<String>();
  }
}