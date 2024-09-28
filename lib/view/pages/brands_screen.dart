import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/view/widgets/add_delete_widget.dart';
import 'package:project_rj_admin_panel/view/widgets/popupcard_title_image_widget.dart';

import '../widgets/brand_list_widget.dart';
import '../widgets/title_content_name_widget.dart';

class BrandsWidgetScreen extends StatelessWidget {
  final String title;
  const BrandsWidgetScreen({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleContentNameWidget(title: title),
        const AddDeleteWidget(),
        BrandsListDataWidget(),
      ],
    );
  }
}


//PopupCardTitleImageWidget(title: 'Add Brand', labelText: 'Enter brand name',);
