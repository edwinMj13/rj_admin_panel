import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/raw%20data/fl_data.dart';
import 'package:project_rj_admin_panel/view/pages/category_screen.dart';
import 'package:project_rj_admin_panel/view/pages/coupon_screen.dart';
import 'package:project_rj_admin_panel/view/pages/dashboard_screen.dart';
import 'package:project_rj_admin_panel/view/pages/products_screen.dart';
import 'package:project_rj_admin_panel/view/providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../../data/raw data/summary_card_data.dart';
import '../../utils/constants.dart';
import '../widgets/summary_card_widget.dart';
import 'brands_screen.dart';

class ContentSection extends StatelessWidget {
  final summaryCardData = SummaryCardData();

  ContentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: secondaryColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _topBar(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Consumer<HomeProvider>(
                builder: (context, value, child) {
                  //bool isVisible=false;
                  return Container(

                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: lightGrey,
                      borderRadius:
                          BorderRadius.all( Radius.circular(10.0)),
                    ),
                    child: //DashBoardWidgetScreen(),
                        getContentScreen(value.index),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding _topBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
      child: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: secondaryColor,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            CircleAvatar(
              radius: 20,
              child: Icon(Icons.person),
            )
          ],
        ),
      ),
    );
  }

  Widget getContentScreen(int index) {
    print(index);
    switch (index) {
      case 0:
        return const DashBoardWidgetScreen(title: 'DashBoard');
      case 1:
        return const ProductScreen(title: "All Products");
      case 2:
        return const CategoryScreen();
      case 3:
        return const BrandsWidgetScreen(title: 'Brands');
      case 4:
        return const CouponScreen(title: 'Coupons');
      default:
        return const SizedBox();
    }
  }
}
