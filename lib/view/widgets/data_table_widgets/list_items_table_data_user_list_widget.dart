import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/brand_model.dart';
import 'package:project_rj_admin_panel/data/models/product_model.dart';
import 'package:project_rj_admin_panel/data/models/user_profile_model.dart';
import 'package:project_rj_admin_panel/data/raw%20data/common_data.dart';
import 'package:project_rj_admin_panel/services/brand_services.dart';
import 'package:project_rj_admin_panel/view/providers/brand_provider.dart';
import 'package:project_rj_admin_panel/view/providers/home_provider.dart';
import 'package:project_rj_admin_panel/view/providers/users_list_provider.dart';
import 'package:project_rj_admin_panel/view/widgets/alternative_like_dropdown_but_popup.dart';
import 'package:project_rj_admin_panel/view/widgets/popupcard_title_image_widget.dart';
import 'package:project_rj_admin_panel/view/widgets/simple_icon_widget.dart';
import 'package:project_rj_admin_panel/utils/common_methods.dart';
import 'package:project_rj_admin_panel/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../config/color.dart';
import '../data_table_image_widget.dart';
import '../list_items_title_widget.dart';

class ListItemsTableWidgetUserList extends StatelessWidget {
  final List<UserProfileModel> listData;
  BrandServices brandServices = BrandServices();

  ListItemsTableWidgetUserList({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width*0.80
        ),
        child: DataTable(
          columns: _createColumn(),
          rows: _createRow(listData, context),
        ),
      ),
    );
  }

  List<DataColumn> _createColumn() {
    return List.generate(
        userTableTitle.length,
            (index) => DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text(
              userTableTitle[index],
              style: const TextStyle(
                  color: secondaryColor, fontWeight: FontWeight.bold),
            )));
  }

  List<DataRow> _createRow(List<UserProfileModel> listData, BuildContext context) {
    return listData.map((e) {
      return DataRow(color: const WidgetStatePropertyAll(Colors.white), cells: [
        DataCell(Center(child: Text(e.name))),
        DataCell(Center(child: Text(e.email))),
        DataCell(Center(
            child:  SimpleIconWidget(
                icon: Icons.delete,
                onPress: () => context.read<UsersListProvider>().deleteUser(e.nodeID),
                iconColor: Colors.red),)),
      ]);
    }).toList();
  }



}
