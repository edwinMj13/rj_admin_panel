import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/config/styles.dart';
import 'package:project_rj_admin_panel/utils/constants.dart';
import 'package:project_rj_admin_panel/view/pages/order_list_screen/widgets/price_breakup_widget.dart';

import '../../../../data/models/order_model.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({
    super.key,
    required this.orderModel,
  });
  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _orderSoftDetails()),
        Expanded(child: _orderAddressDetails()),
        Expanded(child: PriceBreakupWidget(orderModel: orderModel))
      ],
    );
  }

  Column _orderAddressDetails() {
    return Column(
        children: [
          const Text(shippingAddress),
          Text(orderModel.shippingAddress),
        ],
      );
  }

  Column _orderSoftDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$invoiceNumber#${orderModel.invoiceNo}",style: style(fontSize: 19, color: Colors.black, weight: FontWeight.bold),),
          Text("$customerName${orderModel.customerName}",style: style(fontSize: 16, color: Colors.black, weight: FontWeight.normal),),
          Text("$orderDateTime${orderModel.orderDate}, ${orderModel.orderTime}",style: style(fontSize: 16, color: Colors.black, weight: FontWeight.normal),),
          Text("$orderStatus${orderModel.orderStatus}",style: style(fontSize: 16, color: Colors.black, weight: FontWeight.normal),),
          Text("$paymentMethod${orderModel.orderPaymentMethod}",style: style(fontSize: 16, color: Colors.black, weight: FontWeight.normal),),
        ],
      );
  }
}
