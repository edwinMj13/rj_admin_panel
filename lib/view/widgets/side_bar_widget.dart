import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/side_bar_model.dart';
import 'package:project_rj_admin_panel/data/raw%20data/side_bar_raw_data.dart';
import 'package:project_rj_admin_panel/view/providers/home_provider.dart';
import 'package:project_rj_admin_panel/utils/constants.dart';
import 'package:provider/provider.dart';

class SideBarWidget extends StatelessWidget {
  SideBarWidget({super.key});

  final datas = SideBarData();
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondaryColor,
      margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: ListView.builder(
        itemCount: datas.sideBarData.length,
        itemBuilder: (context, index) {
          return sideViewBuild(datas.sideBarData[index], index, context);
        },
      ),
    );
  }

  Widget sideViewBuild(
      SideBarModel sideBarModel, int index, BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) {
        final isSelected = value.index == index;
        // print("${isSelected}  -   ${value.index}  & ${index}");
        return Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: isSelected ? primaryColor : Colors.transparent,
            ),
            child: Material(
              color: isSelected ? primaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(10.0),
              child: InkWell(
                onTap: () {
                  if (index == 2) {
                    isOpen = !isOpen;
                  }
                  value.selectSidePanel(index);
                },
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          sideBarModel.icon,
                          color: isSelected ? secondaryColor : Colors.grey,
                        ),
                      ),
                      Text(
                        sideBarModel.title,
                        style: TextStyle(
                          fontSize: 16,
                          color: isSelected ? secondaryColor : Colors.grey,
                        ),
                      ),
                      /*sideBarModel.subSections != null
                      ?arrowSelection(isSelected, isOpen)
                          :const SizedBox(),
                      // sideBarModel.subSections != null
                      //     ? isOpen
                      // ?const Icon(Icons.keyboard_arrow_up,color: secondaryColor,)
                      // :const Icon(Icons.keyboard_arrow_down,color: Colors.grey,)
                      //     : SizedBox()
                    ],
                  ),
                  sideBarModel.subSections != null && isOpen
                      ? subSection(sideBarModel.subSections,context)
                      : const SizedBox(),*/
                    ],
                  ),
                ]),
              ),
            ));
      },
    );
  }

  Widget arrowSelection(bool isSelected, bool isOpen) {
    late Widget widget;
    if (isSelected && isOpen) {
      widget = const Icon(
        Icons.keyboard_arrow_up,
        color: secondaryColor,
      );
    } else if (isSelected && !isOpen) {
      widget = const Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      );
    } else if (!isSelected) {
      widget = const Icon(
        Icons.keyboard_arrow_down,
        color: Colors.grey,
      );
    }
    return widget;
  }

  subSection(List<String>? lists, BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.lightGreen[50],
      ),
      child: Column(
        children: List.generate(
          lists!.length,
          (index) {
            return Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: InkWell(
                onTap: () {
                  context.read<HomeProvider>().selectCategorySub(index);
                  print("Sub $index");
                },
                child: Text(
                  lists[index],
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
/*
*
*
* */
