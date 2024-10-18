import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/order_model.dart';
import 'package:project_rj_admin_panel/view/pages/order_list_screen/widgets/order_details_list_items_widget.dart';
import 'package:project_rj_admin_panel/view/pages/order_list_screen/widgets/order_summary_widget.dart';

import '../../../../config/styles.dart';
import '../../../../utils/constants.dart';

class PopupOrderDetails extends StatelessWidget {
  const PopupOrderDetails({
    super.key,
    required this.orderModel,
    required this.title,
  });
  final OrderModel orderModel;
  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Container(
      constraints:  BoxConstraints(
        minHeight: size.height * 0.6,
        maxHeight: size.height * 0.7,
        minWidth: size.width * 0.5,
        maxWidth: size.width * 0.6,
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderSummaryWidget(orderModel:orderModel,),
          Container(
            height: 0.5,
            width: double.infinity,
            color: Colors.grey,
          ),
          sizedHeight10,
          Text(cartedItems,style: style(fontSize: 18, color: Colors.black, weight: FontWeight.normal),),
          sizedHeight10,
          Expanded(child: OrderDetailsListItemsWidget(purchaseCartItems:orderModel.purchasedCartList,)),
        ],
      ),
    );
  }
}
