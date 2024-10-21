import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/brand_model.dart';
import 'package:project_rj_admin_panel/data/models/product_model.dart';
import 'package:project_rj_admin_panel/data/raw%20data/common_data.dart';
import 'package:project_rj_admin_panel/services/brand_services.dart';
import 'package:project_rj_admin_panel/view/providers/brand_provider.dart';
import 'package:project_rj_admin_panel/view/providers/home_provider.dart';
import 'package:project_rj_admin_panel/view/widgets/alternative_like_dropdown_but_popup.dart';
import 'package:project_rj_admin_panel/view/widgets/popupcard_title_image_widget.dart';
import 'package:project_rj_admin_panel/view/widgets/simple_icon_widget.dart';
import 'package:project_rj_admin_panel/utils/common_methods.dart';
import 'package:project_rj_admin_panel/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../config/color.dart';
import '../data_table_image_widget.dart';
import '../list_items_title_widget.dart';

class ListItemsTableWidgetBrand extends StatelessWidget {
  final List<BrandModel> listData;
  BrandServices brandServices = BrandServices();

  ListItemsTableWidgetBrand({super.key, required this.listData});

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
        brandTableTitle.length,
        (index) => DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text(
              brandTableTitle[index],
              style: const TextStyle(
                  color: secondaryColor, fontWeight: FontWeight.bold),
            )));
  }

  List<DataRow> _createRow(List<BrandModel> listData, BuildContext context) {
    return listData.map((e) {
      return DataRow(color: const WidgetStatePropertyAll(Colors.white), cells: [
        DataCell(Center(child: DataTableIMAGEWidget(image: e.image))),
        DataCell(Center(child: Text("BR${e.id.toString()}"))),
        DataCell(Center(child: Text(e.name))),
        DataCell(Center(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Text(e.status), _updateStatusButton(context, e)],
        ))),
        __actionButtonSection(context, e)
      ]);
    }).toList();
  }

  IconButton _updateStatusButton(BuildContext context, BrandModel e) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlternativeDropPopup(
                    list: CommonData.statusRawData(),
                    callBack: (selectedValue) {
                      final model = BrandModel(
                          id: e.id,
                          nodeId: e.nodeId,
                          imageRefPath: e.imageRefPath,
                          image: e.image,
                          status: selectedValue,
                          name: e.name);
                      brandServices.brandStatusUpdate(context, model);
                    });
              });
        },
        icon: const Icon(Icons.arrow_drop_down));
  }

  DataCell __actionButtonSection(BuildContext context, BrandModel e) {
    return DataCell(Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SimpleIconWidget(
              icon: Icons.edit,
              onPress: () => brandServices.onEditPress(context, e),
              iconColor: Colors.black),
          SimpleIconWidget(
              icon: Icons.delete,
              onPress: () => brandServices.onDeletePress(context, e.nodeId),
              iconColor: Colors.red),
        ],
      ),
    ));
  }
}
