import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/utils/constants.dart';
import 'package:project_rj_admin_panel/view/widgets/title_content_name_widget.dart';

import '../../widgets/graph_summary_widget.dart';
import '../../widgets/summary_card_widget.dart';
import '../content_screens.dart';

class DashBoardWidgetScreen extends StatelessWidget {
  final String title;

  const DashBoardWidgetScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleContentNameWidget(title: title),
        sizedHeight20,
        SizedBox(
          height: 270,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // width: size.width*0.3,
                // height: 450,
                child: SummaryCardWidget(width: 250,height: 100,),
              ),
              SizedBox(
                width: size.width * 0.4,
                height: 250,
                child:  GraphSummaryWidget(),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width * 0.4,
          height: 250,
          child:  GraphSummaryWidget(),
        ),
      ],
    );
  }
}
