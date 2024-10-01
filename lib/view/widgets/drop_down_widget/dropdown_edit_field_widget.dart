import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/view/providers/category_provider.dart';
import 'package:project_rj_admin_panel/view/providers/common_provider.dart';
import 'package:provider/provider.dart';

class DropDownEDITFormSubCategoryWidget extends StatelessWidget {
  String? selectedValue;
  String label;
  List<dynamic> items=[];
  DropDownEDITFormSubCategoryWidget({
    super.key,
    required this.label,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
          value: selectedValue,
          decoration:  InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
          ),
          items: items
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ),
              )
              .toList(),
          onChanged: (val) {
            selectedValue = val.toString();
            if (label == "Select Category" && selectedValue != null) {
              selectedValue=null;
              context.read<CommonProvider>().getSubCategory(val.toString());
            }
            if(label=="Select Brand"){
              context.read<CommonProvider>().selectedItemString('b', val.toString());
            }else if(label=="Select Category"){
              context.read<CommonProvider>().selectedItemString('c', val.toString());
            }else if(label=="Select Sub-Category"){
              context.read<CommonProvider>().selectedItemString('s', val.toString());
            }
          },
          validator: (value) {
            if (value == null) {
              return "Please Select an item";
            }
            return null;
          },
        );
  }
}
