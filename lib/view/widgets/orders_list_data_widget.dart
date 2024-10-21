import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/brand_model.dart';
import 'package:project_rj_admin_panel/view/providers/brand_provider.dart';
import 'package:project_rj_admin_panel/view/providers/category_provider.dart';
import 'package:project_rj_admin_panel/view/providers/coupon_provider.dart';
import 'package:project_rj_admin_panel/view/providers/order_list_provider.dart';
import 'package:project_rj_admin_panel/view/widgets/data_table_widgets/list_items_table_data_coupon_widget.dart';
import 'package:project_rj_admin_panel/view/widgets/data_table_widgets/list_items_table_data_orer_list_widget.dart';
import 'package:provider/provider.dart';

import '../../repository/common.dart';
import 'data_table_widgets/list_items_table_data_brand_widget.dart';
import 'empty_data_list_widget.dart';

class OrdersListDataWidget extends StatefulWidget {
  const OrdersListDataWidget({super.key, });

  @override
  State<OrdersListDataWidget> createState() => _OrdersListDataWidget();
}

class _OrdersListDataWidget extends State<OrdersListDataWidget> {

  @override
  void initState() {
    // TODO: implement initState
    context.read<OrderListProvider>().getOrderList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderListProvider>(
        builder: (context, value, child) {
           //print("OrderListProvider  -  ${value.orderList}");
          if ( value.orderList.isNotEmpty) {
            return Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
              ),
              child: ListItemsTableDataOrderListWidget(listData: value.orderList,),
            );
          }else{
            return const EmptyDataListWidget();
          }
        }
    );
  }
}