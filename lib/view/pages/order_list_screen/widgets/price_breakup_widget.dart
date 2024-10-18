import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/order_model.dart';

import '../../../../config/styles.dart';
import '../../../../utils/constants.dart';
import '../../../widgets/dotted_line_widget.dart';

class PriceBreakupWidget extends StatelessWidget {
   const PriceBreakupWidget({super.key, required this.orderModel});
  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(priceDetails,
            style: style(
                fontSize: 20, color: Colors.black, weight: FontWeight.bold)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Price (${orderModel.purchasedCartList.length} items)"),
            Text("$rupeeSymbol  ${orderModel.cartOrderTotal}"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$discount ( ${orderModel.orderdiscountPercent}% )",
              style: const TextStyle(color: Colors.green),
            ),
            Text(
              "$rupeeSymbol ${orderModel.orderdiscountAmt}",
              style: const TextStyle(color: Colors.green),
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(deliveryCharges),
            Text("FREE Delivery"),
          ],
        ),
        sizedHeight10,
        const DottedLineWidget(),
        sizedHeight10,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              totalAmount,
              style: style(
                  fontSize: 20, color: Colors.black, weight: FontWeight.bold),
            ),
            Text("$rupeeSymbol ${orderModel.orderlastAmtAfterDiscount}",
                style: style(
                    fontSize: 20,
                    color: Colors.black,
                    weight: FontWeight.bold)),
          ],
        ),
        sizedHeight10,
        const DottedLineWidget(),
        sizedHeight10,
        Center(
            child: RichText(
              text: TextSpan(
                  text: youHaveSaved,
                  style: style(
                      fontSize: 15, color: Colors.green, weight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: "  $rupeeSymbol ${orderModel.orderlastAmtAfterDiscount}  ",
                        style: style(
                            fontSize: 20,
                            color: Colors.green,
                            weight: FontWeight.bold)),
                    TextSpan(
                        text: onThisOrder,
                        style: style(
                            fontSize: 15,
                            color: Colors.green,
                            weight: FontWeight.bold)),
                  ]),
            )),
        sizedHeight10,
      ],
    );
  }
}
