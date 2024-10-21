import 'package:flutter/cupertino.dart';
import 'package:project_rj_admin_panel/data/models/summary_card_model.dart';
import 'package:project_rj_admin_panel/data/models/summary_data_model.dart';

import '../../repository/database_services_order_list.dart';

class GraphSummaryServices {
  final orderDetails = DatabaseServicesOrderList();

  static ValueNotifier<SummaryDataModel> summaryNotifier =
  ValueNotifier(SummaryDataModel(
    totalOrder: "0.0",
    pendingOrder: "0.0",
    completedOrder: "0.0",
    processingOrder: "0.0",
    totalAmountReceived: "0.0",
    totalOrderInJan: "0",
    totalOrderInFeb: "0",
    totalOrderInMar: "0",
    totalOrderInApr: "0",
    totalOrderInMay: "0",
    totalOrderInJun: "0",
    totalOrderInJul: "0",
    totalOrderInAug: "0",
    totalOrderInSep: "0",
    totalOrderInOct: "0",
    totalOrderInNov: "0",
    totalOrderInDec: "0",
  ));

  getGraphData() async {
    final orderList = await orderDetails.getOrderList();
    double pendingOrder = 0.0;
    double completedOrder = 0.0;
    double processingOrder = 0.0;
    double totalAmountReceived = 0.0;
    String totalOrderInJan="0";
    String totalOrderInFeb="0";
    String totalOrderInMar="0";
    String totalOrderInApr="0";
    String totalOrderInMay="0";
    String totalOrderInJun="0";
    String totalOrderInJul="0";
    String totalOrderInAug="0";
    String totalOrderInSep="0";
    String totalOrderInOct="0";
    String totalOrderInNov="0";
    String totalOrderInDec="0";
    for (var model in orderList) {
      totalAmountReceived = totalAmountReceived +
          double.parse(model!.orderlastAmtAfterDiscount).toInt();
      String month = model.orderDate.split(',')[0].split(' ')[0];
      switch (month) {
        case 'January':
          totalOrderInJan = (int.parse(totalOrderInJan) + 1).toString();
          break;
        case 'February':
          totalOrderInFeb = (int.parse(totalOrderInFeb) + 1).toString();
          break;
        case 'March':
          totalOrderInMar = (int.parse(totalOrderInMar) + 1).toString();
          break;
        case 'April':
          totalOrderInApr = (int.parse(totalOrderInApr) + 1).toString();
          break;
        case 'May':
          totalOrderInMay = (int.parse(totalOrderInMay) + 1).toString();
          break;
        case 'June':
          totalOrderInJun = (int.parse(totalOrderInJun) + 1).toString();
          break;
        case 'July':
          totalOrderInJul = (int.parse(totalOrderInJul) + 1).toString();
          break;
        case 'August':
          totalOrderInAug = (int.parse(totalOrderInAug) + 1).toString();
          break;
        case 'September':
          totalOrderInSep = (int.parse(totalOrderInSep) + 1).toString();
          break;
        case 'October':
          totalOrderInOct = (int.parse(totalOrderInOct) + 1).toString();
          break;
        case 'November':
          totalOrderInNov = (int.parse(totalOrderInNov) + 1).toString();
          break;
        case 'December':
          totalOrderInDec = (int.parse(totalOrderInDec) + 1).toString();
          break;
      }
      if (model.orderStatus == "Order Delivered") {
        completedOrder = completedOrder + 1;
      } else if (model.orderStatus == "Order Placed" ||
          model.orderStatus == "Order Shipped") {
        processingOrder = processingOrder + 1;
      } else if (model.orderStatus == "Pending") {
        pendingOrder = pendingOrder + 1;
      }
    }
    summaryNotifier.value = SummaryDataModel(
      totalOrder: orderList.length.toString(),
      pendingOrder: pendingOrder.toString(),
      completedOrder: completedOrder.toString(),
      processingOrder: processingOrder.toString(),
      totalAmountReceived: totalAmountReceived.toString(),
      totalOrderInJan: totalOrderInJan,
      totalOrderInFeb: totalOrderInFeb,
      totalOrderInMar: totalOrderInMar,
      totalOrderInApr: totalOrderInApr,
      totalOrderInMay: totalOrderInMay,
      totalOrderInJun: totalOrderInJun,
      totalOrderInJul: totalOrderInJul,
      totalOrderInAug: totalOrderInAug,
      totalOrderInSep: totalOrderInSep,
      totalOrderInOct: totalOrderInOct,
      totalOrderInNov: totalOrderInNov,
      totalOrderInDec: totalOrderInDec,
    );
  }
}
