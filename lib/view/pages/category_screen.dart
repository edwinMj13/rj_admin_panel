import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/view/providers/home_provider.dart';
import 'package:project_rj_admin_panel/utils/common_methods.dart';
import 'package:provider/provider.dart';
import '../widgets/add_delete_widget.dart';
import '../widgets/category_list_data_widget.dart';
import '../widgets/title_content_name_widget.dart';

class CategoryScreen extends StatelessWidget {

  const CategoryScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleContentNameWidget(title: getSubSectionsCategory(context.watch<HomeProvider>().categorySubIndex)),
        const AddDeleteWidget(),
        const CategoryListDataWidget(),
      ],
    );
  }
}
