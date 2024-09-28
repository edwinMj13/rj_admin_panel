import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier{

  int index=0;
  int categorySubIndex=0;


   selectSidePanel(int indexFrom){
     index=indexFrom;
    notifyListeners();
  }
  selectCategorySub(int indexFrom){
    categorySubIndex=indexFrom;
    notifyListeners();
  }

  selectScreen(){
     notifyListeners();
  }


}