import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_rj_admin_panel/data/models/brand_model.dart';
import 'package:project_rj_admin_panel/data/models/category_model.dart';
import 'package:project_rj_admin_panel/data/models/coupon_model.dart';
import 'package:project_rj_admin_panel/data/models/product_model.dart';
import 'package:project_rj_admin_panel/data/models/storage_image_model.dart';
import 'package:project_rj_admin_panel/services/common_services.dart';
import 'package:project_rj_admin_panel/services/products_services/products_services.dart';
import 'package:project_rj_admin_panel/utils/common_methods.dart';
import 'package:project_rj_admin_panel/view/providers/brand_provider.dart';
import 'package:project_rj_admin_panel/view/providers/coupon_provider.dart';
import 'package:project_rj_admin_panel/view/providers/products_provider.dart';
import 'package:project_rj_admin_panel/view/widgets/popupcard_title_image_widget.dart';
import 'package:project_rj_admin_panel/view/widgets/simple_icon_widget.dart';
import 'package:project_rj_admin_panel/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../data/raw data/common_data.dart';
import '../alternative_like_dropdown_but_popup.dart';
import '../data_table_image_widget.dart';
import '../list_items_title_widget.dart';
import '../text_limited_hundred_widget.dart';

class ListItemsTableWidgetProducts extends StatelessWidget {
  final List<ProductModel> listData;
  ProductServices productServices = ProductServices();

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
        DataCell(Center(
            child: DataTableIMAGEWidget(image: storaList[0].downloadUrl))),
        DataCell(
          TextLimitedHundredWidget(
            name: e.itemName,
          ),
        ),
        DataCell(Center(child: Text(e.category))),
        DataCell(Center(child: Text(e.price))),
        DataCell(Center(child: Text(e.sellingPrize))),
        DataCell(Center(child: Text(e.stock))),
        DataCell(Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
          children: [
            Text(e.status),
            IconButton(
                onPressed: () {
                  _statusPopup(context, e);
                },
                icon: const Icon(Icons.arrow_drop_down))
          ],
        ))),
        __actionButtonSection(context, e)
      ]);
    }).toList();
  }

  void _statusPopup(BuildContext context, ProductModel e) {
    showDialog(
        context: context,
        builder: (context) {
          return AlternativeDropPopup(
            list: CommonData.statusRawData(),
            callBack: (selectedValue) {
              final model = ProductModel(
                firebaseNodeId: e.firebaseNodeId,
                imagesList: getImageListFromDynamic(e.imagesList),
                itemName: e.itemName,
                category: e.category,
                itemMrp: e.itemMrp,
                itemBrand: e.itemBrand,
                price: e.price,
                sellingPrize: e.sellingPrize,
                productId: e.productId,
                stock: e.stock,
                status: selectedValue,
                description: e.description,
                mainImage: e.mainImage,
                subCategory: e.subCategory,
              );
              productServices.updateStatusCategory(context, model);

            },
          );
        });
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
              onPress: () =>
                  productServices.onDeletePress(e.firebaseNodeId, context),
              iconColor: Colors.red),
        ],
      ),
    ));
  }

  //Text _tableItems(String data) => Text(data);

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
