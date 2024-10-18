import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';

import '../../../../data/models/order_cart_purchase_model.dart';

class CircleImagesInOrderList extends StatelessWidget {
  const CircleImagesInOrderList({
    super.key,
    required this.purchaseList,
  });

  final List<OrderCartPurchaseModel> purchaseList;

  @override
  Widget build(BuildContext context) {
    print(purchaseList.length);
    return SizedBox(
      child: FlutterImageStack.providers(
        providers: List.generate(purchaseList.length, (index) {
          return NetworkImage(
            purchaseList[index].itemMainImage,
          );
        }).toList(),
        showTotalCount: true,
        totalCount: purchaseList.length,
        itemRadius: 60,
        // Radius of each images
        itemCount: 2,
        // Maximum number of images to be shown in stack
        itemBorderWidth: 2,
        // Border width around the images
      ),
    );
  }
}
