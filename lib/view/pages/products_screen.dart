import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/view/widgets/products_list_data_widget.dart';

import '../widgets/add_delete_widget.dart';
import '../widgets/title_content_name_widget.dart';

class ProductScreen extends StatelessWidget {
  final String title;
  const ProductScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleContentNameWidget(title: title),
        const AddDeleteWidget(),
        const ProductListDataWidget(),
      ],
    );
  }
}
