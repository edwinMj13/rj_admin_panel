import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/raw%20data/summary_card_data.dart';
import 'package:project_rj_admin_panel/utils/constants.dart';

class SummaryCardWidget extends StatelessWidget {
  final summaryCardData = SummaryCardData();

  SummaryCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customSummaryCard(size,0, summaryCardData),
              sizedHeight20,
              customSummaryCard(size,2, summaryCardData),
            ],
          ),
          sizedWidth20,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customSummaryCard(size,1, summaryCardData),
              sizedHeight20,
              customSummaryCard(size,3, summaryCardData),
            ],
          ),
        ],
      ),
    );
  }

  Widget customSummaryCard(Size size,int index, SummaryCardData summaryCardData) {
    print("SIZE width  - ${size.width}"
        "SIZE height  - ${size.height}");
    return Container(
      height: 100,
      width: 240,
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
                summaryCardData.summaryCard[index].data.toString(),
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
}
