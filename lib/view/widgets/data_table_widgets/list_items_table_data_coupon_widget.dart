import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/brand_model.dart';
import 'package:project_rj_admin_panel/data/models/category_model.dart';
import 'package:project_rj_admin_panel/data/models/coupon_model.dart';
import 'package:project_rj_admin_panel/data/models/product_model.dart';
import 'package:project_rj_admin_panel/view/providers/brand_provider.dart';
import 'package:project_rj_admin_panel/view/providers/coupon_provider.dart';
import 'package:project_rj_admin_panel/view/widgets/popupcard_title_image_widget.dart';
import 'package:project_rj_admin_panel/view/widgets/simple_icon_widget.dart';
import 'package:project_rj_admin_panel/utils/constants.dart';
import 'package:provider/provider.dart';

import '../data_table_image_widget.dart';
import '../list_items_title_widget.dart';

class ListItemsTableWidgetCoupon extends StatelessWidget {
  final List<CouponModel> listData;

  const ListItemsTableWidgetCoupon({super.key, required this.listData});

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
        couponsTableTitle.length,
        (index) => DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text(
              couponsTableTitle[index],
              style: const TextStyle(
                  color: secondaryColor, fontWeight: FontWeight.normal),
            )));
  }

  List<DataRow> _createRow(List<CouponModel> listData, BuildContext context) {
    return listData.map((e) {
      // String st=e.subCategories!.join(",");
      // print(st);
      return DataRow(color: const WidgetStatePropertyAll(Colors.white), cells: [
        DataCell(Center(child: Text("${e.campaignName.toString()}"))),
        DataCell(Center(child: Text(e.code))),
        DataCell(Center(child: Text("${e.discount.toString()}%"))),
        DataCell(Center(child: Text(e.status))),
        _actionButtonSection(context, e)
      ]);
    }).toList();
  }

  DataCell _actionButtonSection(BuildContext context, CouponModel e) {
    return DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SimpleIconWidget(
                icon: Icons.edit,
                onPress: () => onEditPress(context,e),
                iconColor: Colors.black),
            SimpleIconWidget(
                icon: Icons.delete,
                onPress:()=> onDeletePress(e.firebaseCollectionID,context),
                iconColor: Colors.red),
          ],
        ),
      ));
  }

  void onEditPress(BuildContext context, CouponModel model) {
    showDialog(
        context: context,barrierDismissible: false,
        builder: (contexts) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0.0),
            content: PopupCardTitleImageWidget(
              title: "Edit Coupon",
              model: model,
            ),
          );
        });
  }

  void onDeletePress(String firebaseCollectionID,BuildContext context) {
    context.read<CouponProvider>().deleteCoupon(firebaseCollectionID);
  }
}
