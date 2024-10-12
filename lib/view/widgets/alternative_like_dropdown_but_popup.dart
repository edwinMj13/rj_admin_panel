import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/services/common_services.dart';
import 'package:project_rj_admin_panel/services/filter_services.dart';
import 'package:provider/provider.dart';

import '../../services/products_services/products_services.dart';
import '../providers/common_provider.dart';

class AlternativeForDropDown extends StatelessWidget {
  AlternativeForDropDown({
    super.key,
    required this.label,
    this.subList,
    required this.listenable,
  });

  List<String>? subList;
  List<String> listTwo = [];
  final String label;
  final ValueListenable<String> listenable;
  ProductServices productServices = ProductServices();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
        valueListenable: listenable,
        builder: (context, snap, _) {
          return InkWell(
            onTap: () {
              listTwo = FilterServices.populateCatBrandList(context, label);
              if (label == "Sub-Category" && subList==null) {
                print("Not Selected The Category");
              } else {
                openPopup(context);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.2),
                      borderRadius: BorderRadius.circular(3)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      snap,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  void openPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlternativeDropPopup(
            list: _getList(),
            callBack: (selectedValue) {
              FilterServices.selectFromPopupDialog(
                  selectedValue, context, label);
            },
          );
        });
  }

  List<String> _getList() => label == "Sub-Category" ? subList! : listTwo;
}

class AlternativeDropPopup extends StatelessWidget {
  const AlternativeDropPopup({
    super.key,
    required this.list,
    required this.callBack,
  });

  final List<String> list;
  final Function(String) callBack;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(list.length, (index) {
        return InkWell(
          onTap: () {
            callBack(list[index]);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            width: size.width * 0.5,
            child: Center(
              child: Text(
                list[index],
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
        );
      }),
    ));
  }
}
