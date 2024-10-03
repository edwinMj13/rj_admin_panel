import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/brand_model.dart';
import 'package:project_rj_admin_panel/data/models/category_model.dart';
import 'package:project_rj_admin_panel/data/models/product_model.dart';
import 'package:project_rj_admin_panel/services/category_services.dart';
import 'package:project_rj_admin_panel/view/providers/brand_provider.dart';
import 'package:project_rj_admin_panel/view/providers/category_provider.dart';
import 'package:project_rj_admin_panel/view/widgets/popupcard_title_image_widget.dart';
import 'package:project_rj_admin_panel/view/widgets/simple_icon_widget.dart';
import 'package:project_rj_admin_panel/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../utils/common_methods.dart';
import '../../providers/home_provider.dart';
import '../list_items_title_widget.dart';

class ListItemsTableWidgetCategory extends StatelessWidget {
  final List<CategoryModel> listData;
  CategoryServices categoryServices = CategoryServices();
   ListItemsTableWidgetCategory({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: _createColumn(),
        rows: _createRow(listData, context),
      ),
    );
  }

  List<DataColumn> _createColumn() {
    return List.generate(
        categoryTableTitle.length,
        (index) => DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text(
              categoryTableTitle[index],
              style: const TextStyle(
                  color: secondaryColor, fontWeight: FontWeight.normal),
            )));
  }

  List<DataRow> _createRow(List<CategoryModel> listData, BuildContext context) {
    return listData.map((e) {
      String st = e.subCategories!.join(",");
      print(st);
      return DataRow(color: const WidgetStatePropertyAll(Colors.white), cells: [
        DataCell(Center(child: Text("CT${e.id.toString()}"))),
        DataCell(Center(child: Text(e.categoryName))),
        DataCell(Center(child: Text(st))),
        DataCell(Center(child: Text(e.status))),
        DataCell(Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SimpleIconWidget(
                  icon: Icons.edit,
                  onPress: () => onEditPress(context, e),
                  iconColor: Colors.black),
              SimpleIconWidget(
                  icon: Icons.delete,
                  onPress:()=> categoryServices.onDeletePress(context,e.fireID),
                  iconColor: Colors.red),
            ],
          ),
        ))
      ]);
    }).toList();
  }

  void onEditPress(BuildContext context, CategoryModel model) {
   // context.read<CategoryProvider>().editCategory(model);
    String label=getScreenLabel(context.read<HomeProvider>().index);
    context.read<CategoryProvider>().clearCategoryList();
    model.subCategories!.map((e){
      context.read<CategoryProvider>().addToSubCategory(e);
    }).toList();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0.0),
            content: PopupCardTitleImageWidget(
              title: "Edit Category",
              labelText: label,
              model: model,
            ),
          );
        });
  }
}