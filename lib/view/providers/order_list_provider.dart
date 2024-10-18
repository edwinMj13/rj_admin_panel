import 'package:flutter/cupertino.dart';
import 'package:project_rj_admin_panel/data/models/order_model.dart';
import 'package:project_rj_admin_panel/repository/database_services_order_list.dart';
import 'package:project_rj_admin_panel/services/order_list_services.dart';

class OrderListProvider extends ChangeNotifier {

  List<OrderModel?> _orderList = [];
  List<OrderModel?> get orderList => _orderList;

  OrderListServices orderListServices =OrderListServices();

  getOrderList() async {
    _orderList = await orderListServices.getOrderListProvider();
    notifyListeners();
  }

  updateOrderListStatus(OrderModel orderModel,BuildContext context){
    orderListServices.updateOrderStatus(orderModel);
    Navigator.of(context).pop();
    getOrderList();
  }
}