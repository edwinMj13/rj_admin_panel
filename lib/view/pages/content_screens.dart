import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/raw%20data/fl_data.dart';
import 'package:project_rj_admin_panel/view/pages/app_data_screen/app_data_screen.dart';
import 'package:project_rj_admin_panel/view/pages/category_screen.dart';
import 'package:project_rj_admin_panel/view/pages/coupon_screen.dart';
import 'package:project_rj_admin_panel/view/pages/dashboard_screen.dart';
import 'package:project_rj_admin_panel/view/pages/order_list_screen/orders_list_screen.dart';
import 'package:project_rj_admin_panel/view/pages/products_screen.dart';
import 'package:project_rj_admin_panel/view/providers/home_provider.dart';
import 'package:project_rj_admin_panel/view/widgets/top_profile_bar_widget.dart';
import 'package:provider/provider.dart';

import '../../config/color.dart';
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
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const TopProfileBarWidget(),
        Expanded(child: _selectedContent()),
      ],
    );
  }

  Widget _selectedContent() {
    return Padding(
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
                      SingleChildScrollView(child: getContentScreen(value.index)),
                );
              },
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
      case 5:
        return const OrdersListScreen(title: 'Orders');
      case 6:
        return  AppDataScreen();
      default:
        return const SizedBox();
    }
  }
}
