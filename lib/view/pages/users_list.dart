import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/view/widgets/coupon_list_data_widget.dart';
import 'package:project_rj_admin_panel/view/widgets/data_table_widgets/list_items_table_data_coupon_widget.dart';
import 'package:project_rj_admin_panel/view/widgets/orders_list_data_widget.dart';
import 'package:project_rj_admin_panel/view/widgets/users_list_data_widget.dart';

import '../widgets/title_content_name_widget.dart';



class UserListScreen extends StatelessWidget {
  final String title;
  const UserListScreen({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleContentNameWidget(title: title),
        const UsersListDataWidget(),
      ],
    );
  }
}
