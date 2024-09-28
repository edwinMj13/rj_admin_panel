
import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/view/widgets/title_content_name_widget.dart';

import '../widgets/summary_card_widget.dart';
import 'content_screens.dart';

class DashBoardWidgetScreen extends StatelessWidget {
  final String title;
   const DashBoardWidgetScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleContentNameWidget(title: title),
        SummaryCardWidget(),
        //FlChartSummaryWidget(),
      ],
    );
  }
}