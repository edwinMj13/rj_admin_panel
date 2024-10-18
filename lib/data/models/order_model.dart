
import 'order_cart_purchase_model.dart';

class OrderModel {
  final String userNodeId;
  final String orderNodeId;
  final String shippingAddress;
  final String customerName;
  final String orderTime;
  final String orderDate;
  final String paymentId;
  final String orderStatus;
  final String orderPaymentMethod;
  final String cartOrderTotal;
  final String orderlastAmtAfterDiscount;
  final String invoiceNo;
  final String orderdiscountAmt;
  final String orderdiscountPercent;
  String? orderNodeIdInUsers;
  final List<OrderCartPurchaseModel> purchasedCartList;

  OrderModel({
    required this.userNodeId,
    required this.orderNodeId,
    required this.purchasedCartList,
    required this.shippingAddress,
    required this.paymentId,
    required this.orderDate,
    required this.customerName,
    required this.invoiceNo,
    required this.orderTime,
    required this.orderStatus,
    required this.orderPaymentMethod,
    required this.cartOrderTotal,
    required this.orderlastAmtAfterDiscount,
    required this.orderdiscountAmt,
    required this.orderdiscountPercent,
    this.orderNodeIdInUsers,
  });

  Map<String, dynamic> toMap() {
    return {
      "userNodeId": userNodeId,
      "orderNodeId": orderNodeId,
      "shippingAddress": shippingAddress,
      "customerName": customerName,
      "paymentId": paymentId,
      "orderTime": orderTime,
      "invoiceNo": invoiceNo,
      "orderStatus": orderStatus,
      "orderPaymentMethod": orderPaymentMethod,
      "cartOrderTotal": cartOrderTotal,
      "orderlastAmtAfterDiscount": orderlastAmtAfterDiscount,
      "orderdiscountAmt": orderdiscountAmt,
      "orderdiscountPercent": orderdiscountPercent,
      "orderDate": orderDate,
      "orderNodeIdInUsers": orderNodeIdInUsers,
      "purchasedCartList": purchasedCartList.map((item)=>item.toMap()),
    };
  }
//
// factory  OrderModel.{
//   return OrderModel();
// }
}

List<String> orderListTableTitle=[
  "Images",
  "Invoice Id",
  "Customer Name",
  "Method",
  "Amount",
  "Date-Time",
  "Status",
  //"Actions",
];