import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:project_rj_admin_panel/data/models/brand_model.dart';
import 'package:project_rj_admin_panel/data/models/order_model.dart';
import 'package:project_rj_admin_panel/data/models/product_model.dart';
import 'package:project_rj_admin_panel/data/raw%20data/common_data.dart';
import 'package:project_rj_admin_panel/services/brand_services.dart';
import 'package:project_rj_admin_panel/services/order_list_services.dart';
import 'package:project_rj_admin_panel/view/providers/brand_provider.dart';
import 'package:project_rj_admin_panel/view/providers/home_provider.dart';
import 'package:project_rj_admin_panel/view/providers/order_list_provider.dart';
import 'package:project_rj_admin_panel/view/widgets/alternative_like_dropdown_but_popup.dart';
import 'package:project_rj_admin_panel/view/widgets/popupcard_title_image_widget.dart';
import 'package:project_rj_admin_panel/view/widgets/simple_icon_widget.dart';
import 'package:project_rj_admin_panel/utils/common_methods.dart';
import 'package:project_rj_admin_panel/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../config/color.dart';
import '../../../data/models/order_cart_purchase_model.dart';
import '../../pages/order_list_screen/widgets/circle_stack_images_widget.dart';
import '../data_table_image_widget.dart';
import '../list_items_title_widget.dart';

class ListItemsTableDataOrderListWidget extends StatelessWidget {
  final List<OrderModel?> listData;
  final OrderListServices orderListServices = OrderListServices();

  ListItemsTableDataOrderListWidget({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    //print("ListItemsTableDataOrderListWidget  -  $listData");
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        showCheckboxColumn: false,
        decoration: const BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        ),
        columns: _createColumn(),
        rows: _createRow(listData, context),
      ),
    );
  }

  List<DataColumn> _createColumn() {
    return List.generate(
        orderListTableTitle.length,
        (index) => DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text(
              orderListTableTitle[index],
              style: const TextStyle(
                  color: secondaryColor, fontWeight: FontWeight.bold),
            )));
  }

  List<DataRow> _createRow(List<OrderModel?> listData, BuildContext context) {
    return listData.map((e) {
      return DataRow(
        mouseCursor: WidgetStateMouseCursor.clickable,
        color: const WidgetStatePropertyAll(Colors.white),
        onSelectChanged: (selected) {
          if(selected!){
            showOrderDetailsDialog(context,e);
          }
        },
        cells: [
          _imageSection(e!),
          DataCell(Center(child: _withRippleEffect("#${e.invoiceNo}"))),
          DataCell(Center(child: _withRippleEffect(e.customerName))),
          DataCell(Center(child: _withRippleEffect(e.orderPaymentMethod))),
          DataCell(Center(child: _withRippleEffect(e.orderlastAmtAfterDiscount.toString()))),
          DataCell(Center(child: _withRippleEffect("${e.orderDate} ${e.orderTime}"))),
          _orderStatusButton(e, context),
          // __actionButtonSection(context, e),
        ],
      );
    }).toList();
  }

  Text _withRippleEffect(String tag) => Text(tag);

  DataCell _imageSection(OrderModel? e) {
    return DataCell(Center(
        child: SizedBox(
            width: 70,
            child:
                CircleImagesInOrderList(purchaseList: e!.purchasedCartList))));
  }

  DataCell _orderStatusButton(OrderModel e, BuildContext context) {
    return DataCell(Center(
        child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(e.orderStatus),
        _updateStatusButton(context, e),
      ],
    )));
  }

  IconButton _updateStatusButton(BuildContext context, OrderModel e) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlternativeDropPopup(
                    list: CommonData.getOrderStatusList(),
                    callBack: (selectedValue) {
                      print("Selected Value $selectedValue");
                      final model = OrderModel(
                        userNodeId: e.userNodeId,
                        orderNodeId: e.orderNodeId,
                        purchasedCartList: e.purchasedCartList,
                        shippingAddress: e.shippingAddress,
                        invoiceNo: e.invoiceNo,
                        paymentId: e.paymentId,
                        orderDate: e.orderDate,
                        customerName: e.customerName,
                        orderTime: e.orderTime,
                        orderStatus: selectedValue,
                        orderPaymentMethod: e.orderPaymentMethod,
                        cartOrderTotal: e.cartOrderTotal,
                        orderlastAmtAfterDiscount: e.orderlastAmtAfterDiscount,
                        orderdiscountAmt: e.orderdiscountAmt,
                        orderdiscountPercent: e.orderdiscountPercent,
                        orderNodeIdInUsers: e.orderNodeIdInUsers,
                      );
                      context
                          .read<OrderListProvider>()
                          .updateOrderListStatus(model, context);
                    });
              });
        },
        icon: const Icon(Icons.arrow_drop_down));
  }

  void showOrderDetailsDialog(BuildContext context,OrderModel model) {
    showDialog(context: context, builder: (context){
      return Dialog(child: PopupCardTitleImageWidget(title: "Order Details",model: model,));
    });
  }

/*DataCell __actionButtonSection(BuildContext context, OrderModel e) {
    return DataCell(Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SimpleIconWidget(
              icon: Icons.edit,
              onPress: () => orderListServices.onEditPress(context, e),
              iconColor: Colors.black),
          SimpleIconWidget(
              icon: Icons.delete,
              onPress: () => orderListServices.onDeletePress(context, e.orderNodeId),
              iconColor: Colors.red),
        ],
      ),
    ));
  }*/
}

