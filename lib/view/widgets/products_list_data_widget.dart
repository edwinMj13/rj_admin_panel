import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/brand_model.dart';
import 'package:project_rj_admin_panel/view/providers/brand_provider.dart';
import 'package:project_rj_admin_panel/view/providers/category_provider.dart';
import 'package:project_rj_admin_panel/view/providers/coupon_provider.dart';
import 'package:project_rj_admin_panel/view/providers/products_provider.dart';
import 'package:project_rj_admin_panel/view/widgets/data_table_widgets/list_items_table_data_coupon_widget.dart';
import 'package:project_rj_admin_panel/view/widgets/data_table_widgets/list_items_table_data_products_widget.dart';
import 'package:provider/provider.dart';

import '../../repository/common.dart';
import 'data_table_widgets/list_items_table_data_brand_widget.dart';

class ProductListDataWidget extends StatefulWidget {
  const ProductListDataWidget({super.key, });

  @override
  State<ProductListDataWidget> createState() => _ProductListDataWidget();
}

class _ProductListDataWidget extends State<ProductListDataWidget> {

  @override
  void initState() {
    // TODO: implement initState
    context.read<ProductsProvider>().getProductsDataProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
        builder: (context, value, child) {
           print("Products ProductListDataWidget${value.productsList}");
          if (value.productsList == null) {
            return const Center(child: Text("No Data Available"));
          }else if (value.productsList!.isEmpty) {
            return const Center(child: Text("No Data Available"));
          }  else {
            return Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
              ),
              child: ListItemsTableWidgetProducts(listData: value.productsList!,),
            );
          }
        }
    );
  }
}