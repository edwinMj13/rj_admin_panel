import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data/models/order_cart_purchase_model.dart';
import '../data/models/order_model.dart';
import '../data/models/to_model_class.dart';

class DatabaseServicesOrderList {
  final firebase = FirebaseFirestore.instance;

  Future<List<OrderModel?>> getOrderList() async {
    OrderModel? orderModel;
    final data = await firebase.collection("Orders").get();
    final dataMap = data.docs;
    List<OrderModel?> orderList = dataMap.map((model) {
      List<OrderCartPurchaseModel> cartList = [];
      print("Started");
      for (var item in model["purchasedCartList"]) {
        cartList.add(ToModelClass.toPurchaseModel(item));
      }
      orderModel = OrderModel(
        userNodeId: model["userNodeId"],
        orderNodeId: model["orderNodeId"],
        purchasedCartList: cartList,
        shippingAddress: model["shippingAddress"],
        invoiceNo: model["invoiceNo"],
        paymentId: model["paymentId"],
        orderDate: model["orderDate"],
        customerName: model["customerName"],
        orderTime: model["orderTime"],
        orderStatus: model["orderStatus"],
        orderPaymentMethod: model["orderPaymentMethod"].toString(),
        cartOrderTotal: model["cartOrderTotal"].toString(),
        orderlastAmtAfterDiscount: model["orderlastAmtAfterDiscount"].toString(),
        orderdiscountAmt: model["orderdiscountAmt"].toString(),
        orderdiscountPercent: model["orderdiscountPercent"].toString(),
        orderNodeIdInUsers: model["orderNodeIdInUsers"],
      );
      return orderModel;
    }).toList();
    print(orderList);

    print("Finished All");
    return orderList;
  }

  updateOrderStatus(OrderModel model) async {
    print("Order id");
    print(model.orderStatus);
    await firebase
        .collection("Orders")
        .doc(model.orderNodeId)
        .update(model.toMap())
        .then((_) async {
      await firebase
          .collection("Users")
          .doc(model.userNodeId)
          .collection("orders")
          .doc(model.orderNodeId)
          .update(model.toMap()).then((_){
            print("FINISHEdvdvD");
      });
    }).catchError((error){print("ERROR ${error}");});
  }
}
