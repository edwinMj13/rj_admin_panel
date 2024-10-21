import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/firebase_options.dart';
import 'package:project_rj_admin_panel/view/pages/home_screen.dart';
import 'package:project_rj_admin_panel/view/providers/app_data_provider.dart';
import 'package:project_rj_admin_panel/view/providers/brand_provider.dart';
import 'package:project_rj_admin_panel/view/providers/category_provider.dart';
import 'package:project_rj_admin_panel/view/providers/common_provider.dart';
import 'package:project_rj_admin_panel/view/providers/coupon_provider.dart';
import 'package:project_rj_admin_panel/view/providers/graph_summary_provider.dart';
import 'package:project_rj_admin_panel/view/providers/home_provider.dart';
import 'package:project_rj_admin_panel/view/providers/order_list_provider.dart';
import 'package:project_rj_admin_panel/view/providers/pick_image_provider.dart';
import 'package:project_rj_admin_panel/view/providers/products_provider.dart';
import 'package:project_rj_admin_panel/utils/constants.dart';
import 'package:project_rj_admin_panel/view/providers/brand_provider.dart';
import 'package:project_rj_admin_panel/view/providers/pick_image_provider.dart';
import 'package:provider/provider.dart';

import 'config/color.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context) =>HomeProvider()),
        ChangeNotifierProvider(create:(context) =>BrandProvider()),
        ChangeNotifierProvider(create:(context) =>PickImageProvider()),
        ChangeNotifierProvider(create:(context) =>CategoryProvider()),
        ChangeNotifierProvider(create:(context) =>CouponProvider()),
        ChangeNotifierProvider(create:(context) =>ProductsProvider()),
        ChangeNotifierProvider(create:(context) =>CommonProvider()),
        ChangeNotifierProvider(create:(context) =>OrderListProvider()),
        ChangeNotifierProvider(create:(context) =>AppDataProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rj Admin Panel',
        theme: ThemeData(
            scaffoldBackgroundColor: secondaryColor,
            brightness: Brightness.light
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

