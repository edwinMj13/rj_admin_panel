import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/order_cart_purchase_model.dart';
import 'package:project_rj_admin_panel/data/models/order_model.dart';
import 'package:project_rj_admin_panel/utils/constants.dart';
import 'package:project_rj_admin_panel/view/widgets/place_holder_image_widget.dart';

import '../../../../config/styles.dart';

class OrderDetailsListItemsWidget extends StatelessWidget {
  const OrderDetailsListItemsWidget({
    super.key,
    required this.purchaseCartItems,
  });

  final List<OrderCartPurchaseModel> purchaseCartItems;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Row(children: [
            Column(
              children: [
                PlaceHolderImageWidget(image: purchaseCartItems[index].itemMainImage,size: 100,),
                Text("Qty ${purchaseCartItems[index].itemCartedQuantity}")
              ],
            ),
            sizedWidth30,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(purchaseCartItems[index].itemName,style: style(fontSize: 18, color: Colors.black, weight: FontWeight.normal),),
                Text(purchaseCartItems[index].itemCartedLastAmt,style: style(fontSize: 20, color: Colors.green, weight: FontWeight.normal),),
              ],
            ),

          ],);
        },
        separatorBuilder: (context, index) => const Divider(height: 0.5,),
        itemCount: purchaseCartItems.length);
  }
}
