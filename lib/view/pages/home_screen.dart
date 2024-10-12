import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/utils/constants.dart';
import 'package:project_rj_admin_panel/utils/responsive.dart';
import 'package:provider/provider.dart';

import '../providers/common_provider.dart';
import '../widgets/side_bar_widget.dart';
import '../widgets/summary_card_widget.dart';
import 'content_screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    // TODO: implement initState
    context.read<CommonProvider>().getBrandsNames();
    context.read<CommonProvider>().getCategoryNames();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              child: SideBarWidget(),
            ),
          ),
          Container(
            height: double.infinity,
            width: 0.2,
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
          ),
          Expanded(
            flex: 10,
            child: ContentSection(),
          ),
        ],
      ),
    );
  }
}
