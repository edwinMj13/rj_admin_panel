import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/services/common_services.dart';
import 'package:provider/provider.dart';

import '../../services/products_services.dart';
import '../providers/common_provider.dart';

class AlternativeForDropDown extends StatelessWidget {
  AlternativeForDropDown({
    super.key,
    required this.label,
    this.list,
    required this.listenable,
  });

  List<String>? list;
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
              if (label == "Brand") {
                context.read<CommonProvider>().getBrandsNames();
                listTwo = context.read<CommonProvider>().brandsNames!;
              } else if (label == "Category") {
                context.read<CommonProvider>().getCategoryNames();
                listTwo = context.read<CommonProvider>().categoryNames!;
              }
              if (label == "SubCategory" &&
                  ProductServices.subCategoryNotifier.value == "Select") {
                print("Not Selected The Category");
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlternativeDropPopup(
                        list: _getList(),
                        callBack: (selectedValue) {
                          productServices.selectFromPopupDialog(
                              selectedValue, context, label);
                        },
                      );
                    });
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

  List<String> _getList() => label == "Sub-Category" ? list! : listTwo;
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
            width: size.width*0.5,
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
