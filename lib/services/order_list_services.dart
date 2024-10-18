import 'package:flutter/cupertino.dart';
import 'package:project_rj_admin_panel/data/models/brand_model.dart';
import 'package:project_rj_admin_panel/data/models/order_model.dart';
import 'package:project_rj_admin_panel/view/providers/order_list_provider.dart';
import 'package:provider/provider.dart';

import '../repository/database_services_order_list.dart';

class OrderListServices{
  DatabaseServicesOrderList databaseServicesOrderList = DatabaseServicesOrderList();

   updateOrderStatus(OrderModel model) async {
    await databaseServicesOrderList.updateOrderStatus(model);
  }

  Future<List<OrderModel?>> getOrderListProvider() async {
    return await databaseServicesOrderList.getOrderList();
  }

  // onEditPress(BuildContext context, OrderModel e) {}
  //
  // onDeletePress(BuildContext context, nodeId) async {
  //    await databaseServicesOrderList.
  // }
}