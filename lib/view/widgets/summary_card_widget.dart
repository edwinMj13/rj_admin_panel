import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/raw%20data/summary_card_data.dart';
import 'package:project_rj_admin_panel/services/graph_summary_services.dart';
import 'package:project_rj_admin_panel/utils/constants.dart';

class SummaryCardWidget extends StatelessWidget {
  final summaryCardData = SummaryCardData();

  SummaryCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GraphSummaryServices.summaryNotifier,
      builder: (context,value,_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSummaryCard(0, summaryCardData,value.totalOrder),
                sizedHeight20,
                customSummaryCard(2, summaryCardData,value.pendingOrder),
              ],
            ),
            sizedWidth20,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSummaryCard(1, summaryCardData,value.processingOrder),
                sizedHeight20,
                customSummaryCard(3, summaryCardData,value.completedOrder),
              ],
            ),
          ],
        );
      }
    );
  }

  Widget customSummaryCard(int index, SummaryCardData summaryCardData, String data) {

    return Container(
      height: 100,
      width: 250,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: summaryCardData.summaryCard[index].backgroundColor,
            ),
            child: Icon(
              summaryCardData.summaryCard[index].icon,
              size: 25,
              color: summaryCardData.summaryCard[index].color,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                summaryCardData.summaryCard[index].title,
                style: const TextStyle(fontSize: 15, color: Colors.black),
              ),
              Text(
                data,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
}
