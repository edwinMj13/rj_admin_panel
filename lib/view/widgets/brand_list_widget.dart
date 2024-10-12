import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/brand_model.dart';
import 'package:project_rj_admin_panel/view/providers/brand_provider.dart';
import 'package:project_rj_admin_panel/view/providers/category_provider.dart';
import 'package:project_rj_admin_panel/view/widgets/empty_data_list_widget.dart';
import 'package:provider/provider.dart';

import '../../repository/common.dart';
import 'data_table_widgets/list_items_table_data_brand_widget.dart';

class BrandsListDataWidget extends StatefulWidget {
  const BrandsListDataWidget({super.key, });

  @override
  State<BrandsListDataWidget> createState() => _BrandsListDataWidget();
}

class _BrandsListDataWidget extends State<BrandsListDataWidget> {

  @override
  void initState() {
    // TODO: implement initState
    context.read<BrandProvider>().getBrandsProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BrandProvider>(
        builder: (context, value, child) {
          if (value.brandModel != null && value.brandModel!.isNotEmpty) {
            return Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
              ),
              child: ListItemsTableWidgetBrand(listData: value.brandModel!,),
            );
          }else{
            return EmptyDataListWidget();
          }
        }
    );
  }
}