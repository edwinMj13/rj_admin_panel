import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/view/providers/category_provider.dart';
import 'package:provider/provider.dart';

import 'data_table_widgets/list_items_table_data_brand_widget.dart';
import 'data_table_widgets/list_items_table_data_category_widget.dart';

class CategoryListDataWidget extends StatefulWidget {
  const CategoryListDataWidget({super.key});

  @override
  State<CategoryListDataWidget> createState() => _CategoryListDataWidgetState();
}

class _CategoryListDataWidgetState extends State<CategoryListDataWidget> {


  @override
  void initState() {
    // TODO: implement initState
    context.read<CategoryProvider>().getCategoryProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
        builder: (context, value, child) {
          print("CatModel - ${value.cateModel}");
          if ( value.cateModel==null) {
            return const Center(child: Text("No Data Available"));
          }else if(value.cateModel!.isEmpty){
            return const Center(child: Text("No Data Available"));
          } else {
            return Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
              ),
              child: ListItemsTableWidgetCategory(listData: value.cateModel!,),
            );
          }
        }
    );
  }
}
