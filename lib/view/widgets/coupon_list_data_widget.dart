import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/brand_model.dart';
import 'package:project_rj_admin_panel/view/providers/brand_provider.dart';
import 'package:project_rj_admin_panel/view/providers/category_provider.dart';
import 'package:project_rj_admin_panel/view/providers/coupon_provider.dart';
import 'package:project_rj_admin_panel/view/widgets/data_table_widgets/list_items_table_data_coupon_widget.dart';
import 'package:provider/provider.dart';

import '../../repository/common.dart';
import 'data_table_widgets/list_items_table_data_brand_widget.dart';

class CouponListDataWidget extends StatefulWidget {
  const CouponListDataWidget({super.key, });

  @override
  State<CouponListDataWidget> createState() => _CouponListDataWidget();
}

class _CouponListDataWidget extends State<CouponListDataWidget> {

  @override
  void initState() {
    // TODO: implement initState
    context.read<CouponProvider>().getCouponDetailsProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CouponProvider>(
        builder: (context, value, child) {
         // print("Coupon Provider${value.couponList}");
          if (value.couponList == null) {
            return const Center(child: Text("No Data Available"));
          }else if (value.couponList!.isEmpty) {
            return const Center(child: Text("No Data Available"));
          }  else {
            return Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
              ),
              child: ListItemsTableWidgetCoupon(listData: value.couponList!,),
            );
          }
        }
    );
  }
}