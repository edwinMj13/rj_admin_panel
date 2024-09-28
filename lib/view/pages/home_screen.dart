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
    getDrops();
    super.initState();
  }

  getDrops() async {
    await context.read<CommonProvider>().getBrandsNames();
    await context.read<CommonProvider>().getCategoryNames();
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
          Expanded(
            flex: 10,
            child: ContentSection(),
          ),
        ],
      ),
    );
  }
}
