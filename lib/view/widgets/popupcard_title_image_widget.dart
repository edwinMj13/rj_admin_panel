import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/view/pages/order_list_screen/widgets/popup_order_details.dart';
import 'package:project_rj_admin_panel/view/widgets/popup_add_contents/popup_brand_content.dart';
import 'package:project_rj_admin_panel/view/widgets/popup_add_contents/popup_category_content.dart';
import 'package:project_rj_admin_panel/view/widgets/popup_add_contents/popup_coupon_content.dart';
import 'package:project_rj_admin_panel/view/widgets/popup_add_contents/popup_product_content.dart';
import 'package:project_rj_admin_panel/view/widgets/popup_edit_contents/popup_edit_brand_content.dart';
import 'package:project_rj_admin_panel/view/widgets/popup_edit_contents/popup_edit_category_content.dart';
import 'package:project_rj_admin_panel/view/widgets/popup_edit_contents/popup_edit_coupon_content.dart';
import 'package:project_rj_admin_panel/view/widgets/popup_edit_contents/popup_edit_product_content.dart';
import 'package:project_rj_admin_panel/utils/constants.dart';

import '../../config/color.dart';


class PopupCardTitleImageWidget extends StatelessWidget {
  final String title;
  final labelText;
  final dynamic model;

  const PopupCardTitleImageWidget(
      {super.key, required this.title, this.labelText, this.model});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(

      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _popupTitle(),
          _getContent(),
        ],
      ),
    );
  }

  Widget _getContent() {
    switch (title) {
      case "Add Brand":
        return PopupContentBrandWidget(labelText: labelText, title: title);
      case "Edit Brand":
        return PopupEDITContentBrandWidget(labelText: labelText, title: title,model:model);
      case "Add Category":
        return PopupContentCategoryWidget(labelText: labelText, title: title);
      case "Edit Category":
        return PopupEDITContentCategoryWidget(labelText: labelText, title: title,model:model);
      case "Add Coupon":
        return PopupCouponContent(title: title);
      case "Edit Coupon":
        return PopupEDITCouponContent(title: title,model:model);
      case "Add Product":
        return PopupProductContent(title: title);
        case "Edit Product":
          return PopupEDITProductContent(title: title,model:model);
      case "Order Details":
        return PopupOrderDetails(title: title,orderModel:model, );
      // case "Order Details":
      default:
        return const SizedBox();
    }
  }

  Padding _popupTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, color: secondaryColor),
      ),
    );
  }
}
