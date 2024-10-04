import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/brand_model.dart';
import 'package:project_rj_admin_panel/data/models/category_model.dart';
import 'package:project_rj_admin_panel/data/models/coupon_model.dart';
import 'package:project_rj_admin_panel/data/models/product_model.dart';
import 'package:project_rj_admin_panel/data/models/storage_image_model.dart';
import 'package:project_rj_admin_panel/services/products_services.dart';
import 'package:project_rj_admin_panel/utils/common_methods.dart';
import 'package:project_rj_admin_panel/view/providers/brand_provider.dart';
import 'package:project_rj_admin_panel/view/providers/coupon_provider.dart';
import 'package:project_rj_admin_panel/view/providers/products_provider.dart';
import 'package:project_rj_admin_panel/view/widgets/popupcard_title_image_widget.dart';
import 'package:project_rj_admin_panel/view/widgets/simple_icon_widget.dart';
import 'package:project_rj_admin_panel/utils/constants.dart';
import 'package:provider/provider.dart';

import '../list_items_title_widget.dart';

class ListItemsTableWidgetProducts extends StatelessWidget {
  final List<ProductModel> listData;
  ProductServices productServices=ProductServices();

  ListItemsTableWidgetProducts({super.key, required this.listData});

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
        productsTableTitle.length,
        (index) => DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text(
              productsTableTitle[index],
              style: const TextStyle(
                  color: secondaryColor, fontWeight: FontWeight.normal),
            )));
  }

  List<DataRow> _createRow(List<ProductModel> listData, BuildContext context) {

    return listData.map((e) {
      List<StorageImageModel> storaList = getImageListFromDynamic(e.imagesList);

      print(storaList);
      return DataRow(color: const WidgetStatePropertyAll(Colors.white), cells: [
        DataCell(Center(child: _productImage(storaList[0].downloadUrl))),
        DataCell(Center(child: _tableItems(e.itemName))),
        DataCell(Center(child: _tableItems(e.category))),
        DataCell(Center(child: _tableItems(e.price))),
        DataCell(Center(child: _tableItems(e.sellingPrize))),
        DataCell(Center(child: _tableItems(e.stock))),
        DataCell(Center(child: _tableItems(e.status))),
        __actionButtonSection(context, e)
      ]);
    }).toList();
  }

  DataCell __actionButtonSection(BuildContext context, ProductModel e) {
    return DataCell(Center(
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
                onPress: () => productServices.onDeletePress(e.firebaseNodeId, context),
                iconColor: Colors.red),
          ],
        ),
      ));
  }

  Widget _productImage(String image) {
    print("IMages $image");
   return CircleAvatar(
        radius: 20,
        child: ClipRRect(
            child: Image.network(
              image,
            )
          /*FadeInImage(
          image: NetworkImage(
            image,
          ),
          placeholder: AssetImage("assets/placehoderimage.png"),
          imageErrorBuilder: (context, _, e) {
            return Image.asset("assets/placehoderimage.png");
          },
        ),*/
        ));
  }

  Text _tableItems(String data) => Text(data);

  void onEditPress(BuildContext context, ProductModel model) {
    // context.read<CouponProvider>().saveCouponDetailsToEdit(model);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: PopupCardTitleImageWidget(
              title: "Edit Product",
              model: model,
            ),
          );
        });
  }
}
