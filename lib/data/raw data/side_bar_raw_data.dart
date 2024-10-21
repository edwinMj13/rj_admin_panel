import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/side_bar_model.dart';

class SideBarData{
  final sideBarData=<SideBarModel>[
    SideBarModel(title: 'DashBoard', icon: Icons.dashboard),
    SideBarModel(title: 'Products', icon: Icons.shopping_bag),
    SideBarModel(title: 'Category', icon: Icons.category,subSections: ["Category","Sub-Category","Variant-Type","Variant-Item"]),
    SideBarModel(title: 'Brands', icon: Icons.branding_watermark),
    SideBarModel(title: 'Coupon Code', icon: Icons.code),
    SideBarModel(title: 'Orders', icon: Icons.list),
    SideBarModel(title: 'App Data', icon: Icons.margin),
    SideBarModel(title: 'Settings', icon: Icons.settings),
  ];
}