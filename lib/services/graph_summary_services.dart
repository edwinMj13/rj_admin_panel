import 'package:flutter/cupertino.dart';
import 'package:project_rj_admin_panel/data/models/revenue_model.dart';
import 'package:project_rj_admin_panel/data/models/summary_card_model.dart';
import 'package:project_rj_admin_panel/data/models/summary_data_model.dart';
import 'package:project_rj_admin_panel/services/calculations_services.dart';

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

  static ValueNotifier<RevenueModel> revenueNotifier =
      ValueNotifier(RevenueModel(
    totalJan: "0",
    totalFeb: "0",
    totalMar: "0",
    totalApr: "0",
    totalMay: "0",
    totalJun: "0",
    totalJul: "0",
    totalAug: "0",
    totalSep: "0",
    totalOct: "0",
    totalNov: "0",
    totalDec: "0",
  ));

  getGraphData() async {
    final orderList = await orderDetails.getOrderList();
    double pendingOrder = 0.0;
    double completedOrder = 0.0;
    double processingOrder = 0.0;
    double totalAmountReceived = 0.0;
    String totalOrderInJan = "0";
    String totalOrderInFeb = "0";
    String totalOrderInMar = "0";
    String totalOrderInApr = "0";
    String totalOrderInMay = "0";
    String totalOrderInJun = "0";
    String totalOrderInJul = "0";
    String totalOrderInAug = "0";
    String totalOrderInSep = "0";
    String totalOrderInOct = "0";
    String totalOrderInNov = "0";
    String totalOrderInDec = "0";
    String totalJan = "0";
    String totalFeb = "0";
    String totalMar = "0";
    String totalApr = "0";
    String totalMay = "0";
    String totalJun = "0";
    String totalJul = "0";
    String totalAug = "0";
    String totalSep = "0";
    String totalOct = "0";
    String totalNov = "0";
    String totalDec = "0";
    for (var model in orderList) {
      totalAmountReceived = totalAmountReceived +
          double.parse(model!.orderlastAmtAfterDiscount).toInt();
      String month = model.orderDate.split(',')[0].split(' ')[0];
      switch (month) {
        case 'January':
          totalOrderInJan = (int.parse(totalOrderInJan) + 1).toString();
          totalJan = CalculationServices.addValues(
              totalJan, model.orderlastAmtAfterDiscount);
          break;
        case 'February':
          totalOrderInFeb = (int.parse(totalOrderInFeb) + 1).toString();
          totalFeb = CalculationServices.addValues(
              totalFeb, model.orderlastAmtAfterDiscount);
          break;
        case 'March':
          totalOrderInMar = (int.parse(totalOrderInMar) + 1).toString();
          totalMar = CalculationServices.addValues(
              totalMar, model.orderlastAmtAfterDiscount);
          break;
        case 'April':
          totalOrderInApr = (int.parse(totalOrderInApr) + 1).toString();
          totalApr = CalculationServices.addValues(
              totalApr, model.orderlastAmtAfterDiscount);
          break;
        case 'May':
          totalOrderInMay = (int.parse(totalOrderInMay) + 1).toString();
          totalMay = CalculationServices.addValues(
              totalMay, model.orderlastAmtAfterDiscount);
          break;
        case 'June':
          totalOrderInJun = (int.parse(totalOrderInJun) + 1).toString();
          totalJun = CalculationServices.addValues(
              totalJun, model.orderlastAmtAfterDiscount);
          break;
        case 'July':
          totalOrderInJul = (int.parse(totalOrderInJul) + 1).toString();
          totalJul = CalculationServices.addValues(
              totalJul, model.orderlastAmtAfterDiscount);
          break;
        case 'August':
          totalOrderInAug = (int.parse(totalOrderInAug) + 1).toString();
          totalAug = CalculationServices.addValues(
              totalAug, model.orderlastAmtAfterDiscount);
          break;
        case 'September':
          totalOrderInSep = (int.parse(totalOrderInSep) + 1).toString();
          totalSep = CalculationServices.addValues(
              totalSep, model.orderlastAmtAfterDiscount);
          break;
        case 'October':
          totalOrderInOct = (int.parse(totalOrderInOct) + 1).toString();
          totalOct = "12";/*CalculationServices.addValues(
              totalOct, model.orderlastAmtAfterDiscount);*/
          break;
        case 'November':
          totalOrderInNov = (int.parse(totalOrderInNov) + 1).toString();
          totalNov = CalculationServices.addValues(
              totalNov, model.orderlastAmtAfterDiscount);
          break;
        case 'December':
          totalOrderInDec = (int.parse(totalOrderInDec) + 1).toString();
          totalDec = CalculationServices.addValues(
              totalDec, model.orderlastAmtAfterDiscount);
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
    revenueNotifier.value = RevenueModel(
      totalJan: totalJan,
      totalFeb: totalFeb,
      totalMar: totalMar,
      totalApr: totalApr,
      totalMay: totalMay,
      totalJun: totalJun,
      totalJul: totalJul,
      totalAug: totalAug,
      totalSep: totalSep,
      totalOct: totalOct,
      totalNov: totalNov,
      totalDec: totalDec,
    );
  }
}
