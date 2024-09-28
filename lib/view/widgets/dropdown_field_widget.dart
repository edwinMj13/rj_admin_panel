import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/view/providers/category_provider.dart';
import 'package:project_rj_admin_panel/view/providers/common_provider.dart';
import 'package:provider/provider.dart';

class DropDownFormWidget extends StatelessWidget {
  final List<String> items;
  String? selectedValue;
  final String label;

  DropDownFormWidget({
    super.key,
    required this.items,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    print("Drop $items");
    return DropdownButtonFormField(
      value: selectedValue,
      decoration: InputDecoration(
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
        print(val);
        if (label == "Select Category" && selectedValue != null) {
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
